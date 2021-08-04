import 'package:flutter/material.dart';
import 'package:magit/model/task.dart';
import 'package:magit/controller/task_controller.dart';

import 'occurrence_form.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  TaskDetails(this.task);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                'Detalhes:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0),
              ),
              dense: true,
            ),
          ),
          _TaskDetails(widget.task, _setStatus(widget.task), 'Status'),
          _TaskDetails(widget.task, widget.task.housePlace, 'Local'),
          _TaskDetails(widget.task, widget.task.assignedTime, 'Horário'),
          _TaskDetails(widget.task, widget.task.subtitle, 'Descrição'),
          _TaskDetails(widget.task, widget.task.totalHours, 'Tempo Gasto'),
          if (widget.task.paused && widget.task.initiated && widget.task.active)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Retomar a Tarefa'),
                  onPressed: () => TaskController.remove(widget.task).then(
                      (value) => alertSuccess(context, 'Tarefa Retomada',
                                  'Tarefa Retomada com sucesso')
                              .then(
                            (value) => setState(() {}),
                          )),
                ),
              ),
            ),
          if (!widget.task.initiated && widget.task.active)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Iniciar Tarefa'),
                  onPressed: () => TaskController.start(widget.task).then(
                      (value) => alertSuccess(context, 'Tarefa Iniciada',
                                  'Tarefa Iniciada com sucesso')
                              .then(
                            (value) => setState(() {}),
                          )),
                ),
              ),
            ),
          if (!widget.task.paused &&
              widget.task.initiated &&
              widget.task.active)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Pausar Tarefa'),
                  onPressed: () => TaskController.pause(widget.task).then(
                    (value) => alertSuccess(context, 'Tarefa Pausada',
                            'Tarefa Pausada com sucesso')
                        .then(
                      (value) => setState(() {}),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.task.initiated && widget.task.active)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Finalizar tarefa'),
                  onPressed: () => TaskController.end(widget.task).then(
                    (value) => alertSuccess(context, 'Tarefa Finalizada',
                            'Tarefa Finalizada com sucesso')
                        .then(
                      (value) => setState(() {}),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ),
            ),
          if (widget.task.active)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Abrir uma ocorrência'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OcurrenceForm(widget.task),
                      ),
                    );
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Fotos do Local',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                widget.task.imagePath,
                height: 124.0,
              )),
        ],
      ),
    );
  }
}

class _TaskDetails extends StatelessWidget {
  final Task task;

  final String titulo;
  final String subtitulo;

  _TaskDetails(this.task, this.titulo, this.subtitulo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          titulo,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
        ),
        subtitle: Text(subtitulo),
      ),
    );
  }
}

_setStatus(Task task) {
  if (!task.active)
    return 'Tarefa Finalizada';
  else if (task.active && task.paused && task.initiated) {
    return 'Tarefa Pausada';
  } else if (task.active && !task.paused && task.initiated) {
    return 'Tarefa em Andamento';
  } else {
    return 'Tarefa não Iniciada';
  }
}

Future<void> alertSuccess(
    BuildContext context, String title, String subtitle) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(subtitle),
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
