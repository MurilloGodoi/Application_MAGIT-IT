import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'INFORMAÇÕES';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),);
  }
}