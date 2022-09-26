
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flight_system/Auth/LoginWidget.dart';
import 'package:flight_system/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flight_system/Admin/AdminFlight.dart';
import 'package:flight_system/Admin/Admin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MainPage()
    );
  }
}
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
        //   return AdminDashboard();
          return UserPage();
        }
        return LoginWidget();
      },
    )
  );
}

