import 'package:barber_crew/data/y_clients_service.dart';
import 'package:barber_crew/domain/session.dart';
import 'package:flutter/material.dart';

class AvailableDates extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Dates"),
      ),
      body: StreamBuilder<Sessions>(
        stream: YClientsService().fetchSessionForBarberId("123"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final bookingDates = snapshot.data.bookingDates;
          return ListView.builder(
              itemCount: bookingDates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bookingDates[index].toString()),
                );
              });
        },
      ),
    );
  }
}
