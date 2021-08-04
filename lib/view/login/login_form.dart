import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magit/components/login/alertFieldsIncorrects.dart';
import 'package:magit/view/menu/menu.dart';

const _titleAppBar = 'LOGIN';
const _labelName = 'Usuário';
const _labelPassword = 'Senha';
const _labelButtonLogin = 'ENTRAR';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _controllerName = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'images/magit_logo.png',
            height: 124.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: _labelName),
              controller: _controllerName,
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: _labelPassword),
                controller: _controllerPassword,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text(_labelButtonLogin),
                  onPressed: () => _logIn(context),
                ),
              ),
            )
          ]),
        ),
      ]),
    );
  }

  void _logIn(BuildContext context) async {
    final String name = _controllerName.text;
    final String password = _controllerPassword.text;

    if (_checkDataFieldsLogin(name, password)) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: name, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Menu(userCredential.user!.uid)),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        alertFieldsIncorrects(context);
      }
    }
  }

  bool _checkDataFieldsLogin(String name, String password) {
    if (name.length > 0 && password.length > 0) {
      return true;
    }
    return false;
  }
}
