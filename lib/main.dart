import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_firebase/admin/admin1.dart';
import 'package:flutter_appointment_firebase/admin/admin2.dart';
import 'package:flutter_appointment_firebase/user/client1.dart';
import 'package:flutter_appointment_firebase/user/client2.dart';
import 'package:flutter_appointment_firebase/user/client3.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment app firebase',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Developed by Darkbird Studios'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Text('Client 1'),
                Text('Client 2'),
                Text('Client 3'),
                Text('Admin 1'),
                Text('Admin 2'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Client1(),
              Client2(),
              Client3(),
              Admin1(),
              Admin2(),

            ],
          ),
        ));
  }
}
