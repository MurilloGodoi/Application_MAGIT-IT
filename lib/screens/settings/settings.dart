import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'CONFIGURAÇÕES';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),);
  }
}