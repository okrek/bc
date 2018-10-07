import 'package:barber_crew/data/y_clients_service.dart';
import 'package:barber_crew/domain/barber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'available_dates.dart';

class _ShowBarberListAction {
  final List<Barber> barbers;

  _ShowBarberListAction(this.barbers);
}

class ShowLoadingAction {}

class FetchBarbersAction {}

class _BarberListState {
  final List<Barber> barbers;

  _BarberListState(this.barbers);
}

_BarberListState _barberListStateReducer(_BarberListState state, dynamic action) {
  if (action is _ShowBarberListAction) {
    return _BarberListState(action.barbers);
  }

  return _BarberListState(null);
}

void _fetchBarbersMiddleware(Store<_BarberListState> store, action, NextDispatcher next) {
  next(action);

  if (action is FetchBarbersAction) {
    store.dispatch(ShowLoadingAction());
    YClientsService().fetchBarbers().listen((data) {
      store.dispatch(_ShowBarberListAction(data));
    });
  }
}

class BarberList extends StatelessWidget {
  final store = Store<_BarberListState>(_barberListStateReducer, middleware: [_fetchBarbersMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<_BarberListState, List<Barber>>(
        onInit: (store) => store.dispatch(FetchBarbersAction()),
        converter: (store) => store.state.barbers,
        builder: (context, barbers) {
          Widget body;
          if (barbers == null) {
            body =  Center(
              child: CircularProgressIndicator(),
              );
          } else {
            body =  ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) => _buildListItem(context, barbers[index]),
              );
          }

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Barber list"),
              ),
              body: body,
            ),
          );
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Barber barber) {
    return ListTile(
      leading: Container(
          width: 48.0,
          height: 48.0,
          alignment: AlignmentDirectional.center,
          child: Text(
            "${barber.rating}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.green[500],
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
          )),
      title: Text(barber.name),
      subtitle: Text(barber.specialization),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AvailableDates()));
      },
    );
  }
}
