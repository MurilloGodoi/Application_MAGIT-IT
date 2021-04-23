import 'package:flutter/material.dart';

const _alertTitle = 'Usuario ou senha incorreto(a)s';
const _alertSubTitle = 'Por favor preencha os campos corretamente';

Future<void> alertFieldsIncorrects(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_alertTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_alertSubTitle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }