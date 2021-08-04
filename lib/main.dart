import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:magit/view/login/login_form.dart';
import 'package:magit/utils/blockRotation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginForm(),
    },
  ));
}

class MagitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    portraitModeOnly();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[700],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: LoginForm(),
    );
  }
}
