import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magit/components/login/alertFieldsIncorrects.dart';
import 'package:magit/database/dao/user_dao.dart';
import 'package:magit/screens/menu/menu.dart';

const _titleAppBar = 'LOGIN';

const _labelEmail = 'Email';
const _labelPassword = 'Senha';
const _labelButtonLogin = 'ENTRAR';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  final UserDao _userDao = UserDao();

  @override
  Widget build(BuildContext context) {
    /// Descomente as duas linhas de baixo para criar um usuário
    /// é preciso rodar o app com essas duas linhas, após isso vc pode exclui-la e já logar com seu usuario criado 
    //final User user = User('Daniel', 'daniel@gmail.com', '123456');
    //_userDao.create(user);
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
              decoration: InputDecoration(labelText: _labelEmail),
              controller: _controllerEmail,
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

  void _logIn(BuildContext context) {
    final String email = _controllerEmail.text;
    final String password = _controllerPassword.text;

    if (_checkDataFieldsLogin(email, password)) {
      _userDao.find(email, password).then((users) {
        if (users.length > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Menu(users[0])),
          );
        } else {
          alertFieldsIncorrects(context);
        }
      });
    }
  }

  bool _checkDataFieldsLogin(String email, String password) {
    if (email.length > 0 && password.length > 0) {
      return true;
    }
    return false;
  }
}
