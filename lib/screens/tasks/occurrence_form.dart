import 'package:flutter/material.dart';

const _titleAppBar = 'CRIANDO OCORRÊNCIA';

const _labelOcurrence = 'Ocorrência';
const _labelButtonOcurrence = 'Criar Ocorrência';

class OcurrenceForm extends StatefulWidget {
  @override
  _OcurrenceFormState createState() => _OcurrenceFormState();
}

class _OcurrenceFormState extends State<OcurrenceForm> {
  final TextEditingController _ocurrenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: _labelOcurrence),
            controller: _ocurrenceController,
            style: TextStyle(fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: Text(_labelButtonOcurrence),
                onPressed: () => _createOcurrence(context),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _createOcurrence(BuildContext context) {
    final String ocurrence = _ocurrenceController.text;

    if (_checkDataFieldOcurrence(ocurrence)) {
      Navigator.pop(context);
    } else {
      alertOcurrenceIncorrects(context);
    }
  }

  bool _checkDataFieldOcurrence(String ocurrence) {
    if (ocurrence.length > 0) {
      return true;
    }
    return false;
  }
}

Future<void> alertOcurrenceIncorrects(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ocorrência incorreta'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Por favor insira uma ocorrência'),
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
