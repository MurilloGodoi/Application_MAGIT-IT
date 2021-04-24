import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'TAREFAS';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),);
  }
}