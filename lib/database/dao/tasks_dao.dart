import 'package:magit/models/task.dart';
import 'package:magit/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../database_magit.dart';

const String _tableName = 'tasks';

class TasksDao {
  Future create(Task task) async {
    try {
      final Database db = await getDatabase();
      Map<String, dynamic> taskMap = _toMap(task);
      await db.insert(
        _tableName,
        taskMap,
      );
    } catch (error) {
      print(error);
    }
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = Map();

    taskMap['userId'] = task.userId;
    taskMap['active'] = task.active;
    taskMap['paused'] = task.paused;
    taskMap['initiated'] = task.initiated;
    taskMap['title'] = task.title;
    taskMap['subtitle'] = task.subtitle;
    taskMap['housePlace'] = task.housePlace;
    taskMap['assignedDate'] = task.assignedDate;
    taskMap['assignedTime'] = task.assigedTime;
    taskMap['imagePath'] = task.imagePath;
    taskMap['totalHours'] = task.totalHours;
    return taskMap;
  }

  Future<List<Task>> findTasksActiveByDateAndByUserId(User user) async {
    int idUser = user.id;
    DateTime now = new DateTime.now();
    DateTime dateaux = new DateTime(now.year, now.month, now.day);
    String date = dateaux.toString();
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> results = await db.rawQuery(
          'SELECT * FROM tasks WHERE assignedDate=? and userId=? and active=? and assignedDate=? ORDER BY assignedTime ASC ',
          [date, idUser, 1, date]);
      List<Task> tasks = _toList(results);
      return tasks;
    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<List<Task>> findTasksDisableByDateAndByUserId(User user) async {
    int idUser = user.id;
    DateTime now = new DateTime.now();
    DateTime dateaux = new DateTime(now.year, now.month, now.day);
    String date = dateaux.toString();
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> results = await db.rawQuery(
          'SELECT * FROM tasks WHERE assignedDate=? and userId=? and active=? and assignedDate=? ORDER BY assignedTime ASC ',
          [date, idUser, 0, date]);
      List<Task> tasks = _toList(results);
      return tasks;
    } catch (error) {
      print(error);
    }
    return [];
  }

  List<Task> _toList(List<Map<String, dynamic>> results) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> result in results) {
      final Task task = Task(
          result['userId'],
          result['active'],
          result['paused'],
          result['initiated'],
          result['title'],
          result['subtitle'],
          result['housePlace'],
          result['assignedDate'],
          result['assignedTime'],
          result['imagePath'],
          result['totalHours'].toString());
      task.id = result['id'];
      task.startTime = result['startTime'];
      task.endTime = result['endTime'];
      task.auxTime = result['auxTime'];
      task.occurrence = result['occurrence'];

      tasks.add(task);
    }
    return tasks;
  }

  Future startTask(Task task) async {
    task.initiated = 1;
    int id = task.id;
    try {
      final Database db = await getDatabase();
      await db
          .rawUpdate('UPDATE tasks SET initiated = ?  WHERE id = ?', [1, id]);
      await setStartTime(task);
    } catch (error) {
      print(error);
    }
  }

  Future pauseTask(Task task) async {
    task.paused = 1;
    int id = task.id;
    try {
      final Database db = await getDatabase();
      db.rawUpdate('UPDATE tasks SET paused = ?  WHERE id = ?', [1, id]);
    } catch (error) {
      print(error);
    }
  }

  Future removePauseTask(Task task) async {
    task.paused = 0;
    int id = task.id;
    try {
      final Database db = await getDatabase();
      db.rawUpdate('UPDATE tasks SET paused = ?  WHERE id = ?', [0, id]);
    } catch (error) {
      print(error);
    }
  }

  Future endTask(Task task) async {
    task.active = 0;
    int id = task.id;
    try {
      final Database db = await getDatabase();
      await db.rawUpdate('UPDATE tasks SET active = ?  WHERE id = ?', [0, id]);
      await setEndTime(task);
      await setTotalHours(task);
    } catch (error) {
      print(error);
    }
  }

  Future setStartTime(Task task) async {
    int id = task.id;
    var nowDateTime = DateTime.now().toString();
    try {
      final Database db = await getDatabase();
      db.rawUpdate(
          'UPDATE tasks SET startTime = ?  WHERE id = ?', [nowDateTime, id]);
    } catch (error) {
      print(error);
    }
  }

  Future setEndTime(Task task) async {
    int id = task.id;
    var nowDateTime = DateTime.now().toString();
    try {
      final Database db = await getDatabase();
      db.rawUpdate(
          'UPDATE tasks SET endTime = ?  WHERE id = ?', [nowDateTime, id]);
    } catch (error) {
      print(error);
    }
  }

  Future setTotalHours(Task task) async {
    int id = task.id;
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> result = (await db
          .rawQuery('SELECT startTime, endTime FROM tasks WHERE id=?', [id]));

      final startTime = DateTime.tryParse(result[0]['startTime']);
      final endTime = DateTime.tryParse(result[0]['endTime']);
      final diffenceHours = endTime!.difference(startTime!).inHours;
      final differenceMinutes = endTime.difference(startTime).inMinutes;
      final differenceSeconds = endTime.difference(startTime).inSeconds;
      String totalHours =
          '$diffenceHours:$differenceMinutes:$differenceSeconds';
      task.totalHours = totalHours;

      db.rawUpdate(
          'UPDATE tasks SET totalHours = ?  WHERE id = ?', [totalHours, id]);
    } catch (error) {
      print(error);
    }
  }

  Future clearTasks() async {
    try {
      final Database db = await getDatabase();
      db.rawDelete('DELETE FROM tasks');
    } catch (error) {}
  }
}
