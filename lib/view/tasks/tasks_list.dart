import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magit/components/tasks/animated_loading.dart';
import 'package:magit/model/task.dart';
import 'package:magit/view/tasks/tasks_details.dart';
import 'package:intl/intl.dart';

const _titleAppBar = 'TAREFAS';
const _firstTitleDescription = 'Tarefas em aberto:';
const _secondTitleDescription = 'Tarefas finalizadas:';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState(uid);

  final String uid;

  const TasksList(this.uid);
}

class _TasksListState extends State<TasksList> {
  late Query<Map<String, dynamic>> tasksActivesByUserLogged;
  late Query<Map<String, dynamic>> tasksDisabledByUserLogged;
  late CollectionReference tasks;

  @override
  void initState() {
    super.initState();
    tasks = FirebaseFirestore.instance.collection('tasks');
    tasks.snapshots().listen((event) {
      event.docs.forEach((element) {
        print('Id: ${element.id}');
        print('Id: ${element['title']}');
      });
    });

   final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  print(formatted); 

    tasksActivesByUserLogged = FirebaseFirestore.instance
        .collection('tasks')
        .where('userId', isEqualTo: uid)
        .where('active', isEqualTo: true)
        .where('assignedDate', isEqualTo: formatted)
        .orderBy('assignedTime');
    tasksDisabledByUserLogged = FirebaseFirestore.instance
        .collection('tasks')
        .where('userId', isEqualTo: uid)
        .where('active', isEqualTo: false)
        .where('assignedDate', isEqualTo: formatted)
        .orderBy('assignedTime');
  }

  final String uid;

  _TasksListState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_titleAppBar),
        ),
        body: Column(
          children: [
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
            StreamBuilder<QuerySnapshot>(
              stream: tasksActivesByUserLogged.snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(child: Text('Erro ao conectar ao Firebase'));

                  case ConnectionState.waiting:
                    return AnimatedLoading('Carregando...');

                  default:
                    final data = snapshot.requireData;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return taskItemActive(context, data.docs[index]);
                        });
                }
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
            StreamBuilder<QuerySnapshot>(
                stream: tasksDisabledByUserLogged.snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(
                          child: Text('Erro ao conectar ao Firebase'));

                    case ConnectionState.waiting:
                      return AnimatedLoading('Carregando...');

                    default:
                      final data = snapshot.requireData;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            return taskItemDisabled(context, data.docs[index]);
                          });
                  }
                }),
          ],
        ));
  }
}

// ignore: must_be_immutable
Widget taskItemActive(BuildContext context, item) {
  //final Task task;
  //final User user;

  //_TasksListState parent;
  Task task = Task.fromJson(item.data(), item.id);

  return Card(
    child: ListTile(
        leading: Text(task.assignedTime),
        title: Text(
          task.title,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
        ),
        subtitle: Text(task.housePlace),
        onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TaskDetails(task),
              ),
              // ignore: invalid_use_of_protected_member
            )),
    //.then(
    // ignore: invalid_use_of_protected_member
    // (value) => this.parent.setState(() {}),
    // )),
  );
}

Widget taskItemDisabled(BuildContext context, item) {
  Task task = Task.fromJson(item.data(), item.id);

  return Card(
    child: ListTile(
        leading: Text(
          task.assignedTime,
          style: TextStyle(color: Colors.grey),
        ),
        title: Text(
          task.title,
          style: TextStyle(color: Colors.grey, fontSize: 16.0),
        ),
        subtitle: Text(task.housePlace),
        onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TaskDetails(task),
              ),
              // ignore: invalid_use_of_protected_member
            )),
  );
}
