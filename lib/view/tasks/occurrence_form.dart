import 'package:flutter/material.dart';
import 'package:magit/model/task.dart';
import 'package:magit/view/tasks/tasks_details.dart';
import 'package:magit/services/task_service.dart';

const _titleAppBar = 'CRIANDO OCORRÊNCIA';

const _labelOcurrence = 'Ocorrência';
const _labelButtonOcurrence = 'Criar Ocorrência';

class OcurrenceForm extends StatefulWidget {
  final Task task;

  OcurrenceForm(this.task);
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
                onPressed: () => _createOcurrence(context, widget.task),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future _createOcurrence(BuildContext context, Task task) async {
    final String occurrence = _ocurrenceController.text;

    if (_checkDataFieldOcurrence(occurrence)) {
      TaskService.createOccurrenceTask(occurrence, task).then((value) =>
          alertSuccess(
                  context, 'Ocorrência Criada', 'Ocorrência criada com sucesso')
             );
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
