import 'package:magit/models/task.dart';

class User {
  late int id;
  final String nome;
  final String email;
  final String password;
  List<Task> _enabledTasks = [];
  List<Task> _disabledTasks = [];

  User(this.nome, this.email, this.password);

  void addEnabledTasks(Task task) {
    this._enabledTasks.add(task);
  }

  void addDisabledTasks(Task task) {
    this._disabledTasks.add(task);
  }
}
