import 'package:flutter/material.dart';
import 'package:magit/database/dao/tasks_dao.dart';
import 'package:magit/models/task.dart';
import 'package:magit/models/user.dart';

import 'occurrence_form.dart';

class TaskDetails extends StatefulWidget {
  final User user;
  final Task task;

  TaskDetails(this.user, this.task);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final TasksDao _taskDao = TasksDao();

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
          _TaskDetails(
              widget.task, widget.user, _setStatus(widget.task), 'Status'),
          _TaskDetails(
              widget.task, widget.user, widget.task.housePlace, 'Local'),
          _TaskDetails(
              widget.task, widget.user, widget.task.assigedTime, 'Horário'),
          _TaskDetails(
              widget.task, widget.user, widget.task.subtitle, 'Descrição'),
          _TaskDetails(
              widget.task, widget.user, widget.task.totalHours, 'Tempo Gasto'),
          if (widget.task.paused == 1 &&
              widget.task.initiated == 1 &&
              widget.task.active == 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Retomar a Tarefa'),
                  onPressed: () => _taskDao.removePauseTask(widget.task).then(
                      (value) => alertSuccess(context, 'Tarefa Retomada',
                                  'Tarefa Retomada com sucesso')
                              .then(
                            (value) => setState(() {}),
                          )),
                ),
              ),
            ),
          if (widget.task.initiated == 0 && widget.task.active == 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Iniciar Tarefa'),
                  onPressed: () => _taskDao.startTask(widget.task).then(
                      (value) => alertSuccess(context, 'Tarefa Iniciada',
                                  'Tarefa Iniciada com sucesso')
                              .then(
                            (value) => setState(() {}),
                          )),
                ),
              ),
            ),
          if (widget.task.paused == 0 &&
              widget.task.initiated == 1 &&
              widget.task.active == 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Pausar Tarefa'),
                  onPressed: () => _taskDao.pauseTask(widget.task).then(
                        (value) => alertSuccess(context, 'Tarefa Pausada',
                                'Tarefa Pausada com sucesso')
                            .then(
                          (value) => setState(() {}),
                        ),
                      ),
                ),
              ),
            ),
          if (widget.task.initiated == 1 && widget.task.active == 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Finalizar tarefa'),
                  onPressed: () => _taskDao.endTask(widget.task).then(
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
          if (widget.task.active == 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Abrir uma ocorrência'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OcurrenceForm(),
                      ),
                    );
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text('Fotos do Local', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.task.imagePath,
              height: 124.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskDetails extends StatelessWidget {
  final Task task;
  final User user;
  final String titulo;
  final String subtitulo;

  _TaskDetails(this.task, this.user, this.titulo, this.subtitulo);

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
  if (task.active == 0)
    return 'Tarefa Finalizada';
  else if (task.active == 1 && task.paused == 1 && task.initiated == 1) {
    return 'Tarefa Pausada';
  } else if (task.active == 1 && task.paused == 0 && task.initiated == 1) {
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
