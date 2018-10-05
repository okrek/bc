import 'package:barber_crew/data/y_clients_service.dart';
import 'package:flutter/material.dart';
import 'package:barber_crew/domain/barber.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        ),
      home: new StartScreen(),
      );
  }
}

class StartScreen extends StatelessWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(color: Colors.red),
        child: SafeArea(
          child: BCButton(
            title: "Запись",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
                );
            },
            ),
          ),
        ),
      );
  }
}

class BCButton extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Function() onTap;

  const BCButton({this.title, this.titleColor = Colors.white, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 1.0, color: titleColor)),
        padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
        alignment: AlignmentDirectional.center,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.8,
        height: 48.0,
        child: Text(
          title,
          style: TextStyle(color: titleColor),
          ),
        ),
      );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: YClientsService().fetchBarbers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }

            final barbers = snapshot.data as List<Barber>;
            return ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                final barber = barbers[index];
                return ListTile(leading: Container(
                                                   width: 48.0,
                                                   height: 48.0,
                                                   decoration: BoxDecoration(color: Colors.green[500],
                                                                             borderRadius: BorderRadius.all(Radius.circular(24.0)))),
                                  title: Text(barber.name),
                                  subtitle: Text(barber.information),);
              },);
          },
          ),
        ),
    );
  }
}
