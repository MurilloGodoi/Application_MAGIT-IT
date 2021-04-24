import 'package:flutter/material.dart';
import 'package:magit/models/user.dart';
import 'package:magit/screens/information/information.dart';
import 'package:magit/screens/settings/settings.dart';
import 'package:magit/screens/tasks/tasks_list.dart';

const _titleAppBar = 'MENU';

const _titleDescriptionScreen = 'Escolha uma das opções:';

const _titleCardTasks = 'Tarefas do dia';
const _subtitleCardTasks = 'Veja suas tarefas de hoje';

const _titleCardInformation = 'Informações';
const _subtitleCardInformation = 'Veja as informações';

const _titleCardSettings = 'Configurações';
const _subtitleCardSettings = 'Edite suas configurações';

class Menu extends StatelessWidget {
  final User _user;

  const Menu(this._user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                _titleDescriptionScreen,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0),
              ),
              dense: true,
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(
                _titleCardTasks,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0),
              ),
              subtitle: Text(_subtitleCardTasks),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TasksList()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.article),
              title: Text(
                _titleCardInformation,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0),
              ),
              subtitle: Text(_subtitleCardInformation),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Information()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                _titleCardSettings,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0),
              ),
              subtitle: Text(_subtitleCardSettings),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
