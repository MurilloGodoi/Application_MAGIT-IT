import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magit/components/tasks/animated_loading.dart';
import 'package:magit/database/dao/tasks_dao.dart';
import 'package:magit/models/task.dart';
import 'package:magit/models/user.dart';
import 'package:magit/screens/tasks/tasks_details.dart';

const _titleAppBar = 'TAREFAS';

const _titlePossibleError = 'Erro ao buscar as tarefas';

const _titleDataSearch = 'Buscando as tarefas...';

const _firstTitleDescription = 'Tarefas em aberto:';

const _secondTitleDescription = 'Tarefas finalizadas:';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState(user);

  final User user;

  const TasksList(this.user);
}

class _TasksListState extends State<TasksList> {
  final User user;

  _TasksListState(this.user);

  final TasksDao _tasksDao = TasksDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                _firstTitleDescription,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0),
              ),
              dense: true,
            ),
          ),
          FutureBuilder<List<Task>>(
            initialData: [],
            future: Future.delayed(Duration(seconds: 2)).then(
              (value) => _tasksDao.findTasksActiveByDateAndByUserId(user),
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;

                case ConnectionState.waiting:
                  return AnimatedLoading(_titleDataSearch);

                case ConnectionState.active:
                  break;

                case ConnectionState.done:
                  final List<Task>? tasks = snapshot.data;
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final Task task = tasks![index];
                        return _TaskItemActive(task, user, this);
                      },
                      itemCount: tasks!.length,
                    ),
                  );
              }
              return Text(_titlePossibleError);
            },
          ),
          Card(
            child: ListTile(
              title: Text(
                _secondTitleDescription,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16.0),
              ),
              dense: true,
            ),
          ),
          FutureBuilder<List<Task>>(
            initialData: [],
            future: Future.delayed(Duration(seconds: 2)).then(
              (value) => _tasksDao.findTasksDisableByDateAndByUserId(user),
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;

                case ConnectionState.waiting:
                  return AnimatedLoading(_titleDataSearch);

                case ConnectionState.active:
                  break;

                case ConnectionState.done:
                  final List<Task>? tasks = snapshot.data;
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final Task task = tasks![index];
                        return _TaskItemDisabled(task, user);
                      },
                      itemCount: tasks!.length,
                    ),
                  );
              }
              return Text(_titlePossibleError);
            },
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _TaskItemActive extends StatelessWidget {
  final Task task;
  final User user;

  _TasksListState parent;

  _TaskItemActive(this.task, this.user, this.parent);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Text(task.assigedTime),
          title: Text(
            task.title,
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 16.0),
          ),
          subtitle: Text(task.housePlace),
          onTap: () => Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => TaskDetails(user, task),
                ),
                // ignore: invalid_use_of_protected_member
              )
              .then(
                // ignore: invalid_use_of_protected_member
                (value) => this.parent.setState(() {}),
              )),
    );
  }
}

class _TaskItemDisabled extends StatelessWidget {
  final Task task;
  final User user;

  _TaskItemDisabled(this.task, this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          task.assigedTime,
          style: TextStyle(color: Colors.grey),
        ),
        title: Text(
          task.title,
          style: TextStyle(color: Colors.grey, fontSize: 16.0),
        ),
        subtitle: Text(task.housePlace),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(user, task),
          ),
        ),
      ),
    );
  }
}
