import 'package:flutter/material.dart';
import 'package:magit/models/user.dart';

const _menuTitle = 'MENU';

class Menu extends StatelessWidget {
  final User _user;

  const Menu(this._user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_menuTitle),
      ),
      body: Column(
        children: <Widget>[
          Text(_user.id.toString()),
          Text(_user.nome),
          Text(_user.email),
          Text(_user.password),
        ],
      ),
    );
  }
}