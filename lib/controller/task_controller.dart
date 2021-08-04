import 'package:magit/model/task.dart';
import 'package:magit/services/task_service.dart';

class TaskController {
  static Future start(Task task) async {
    try {
      await TaskService.startTask(task);
    } catch (e) {
      print(e);
    }
  }

  static Future pause(Task task) async {
    try {
      await TaskService.pauseTask(task);
    } catch (e) {
      print(e);
    }
  }

  static Future remove(Task task) async {
    try {
      await TaskService.removeTask(task);
    } catch (e) {
      print(e);
    }
  }

  static Future end(Task task) async {
    try {
      await TaskService.endTask(task);
    } catch (e) {
      print(e);
    }
  }

  static Future createOccurrence(String occurrence, Task task) async {
    try {
      await TaskService.createOccurrenceTask(occurrence, task);
    } catch (e) {
      print(e);
    }
  }
}
