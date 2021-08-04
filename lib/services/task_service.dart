import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magit/model/task.dart';

class TaskService {
  static Future startTask(Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    var nowDateTime = DateTime.now().toString();
    await tasks
        .doc(task.id)
        .update({"initiated": true, "startTime": nowDateTime});
    task.initiated = true;
    task.startTime = nowDateTime;
  }

  static Future pauseTask(Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    await tasks.doc(task.id).update({"paused": true});
    task.paused = true;
  }

  static Future removeTask(Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    await tasks.doc(task.id).update({"paused": false});
    task.paused = false;
  }

  static Future endTask(Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    await tasks.doc(task.id).update({"active": false});
    task.active = false;
    await setEndTime(task);
    await setTotalHours(task);
  }

  static Future setEndTime(Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    var nowDateTime = DateTime.now().toString();
    await tasks.doc(task.id).update({"endTime": nowDateTime});
    task.endTime = nowDateTime;
  }

  static Future setTotalHours(Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    DocumentSnapshot taskFound = await tasks.doc(task.id).get();
    final startTime = DateTime.tryParse(taskFound.get('startTime'));
    final endTime = DateTime.tryParse(taskFound.get('endTime'));
    final diffenceHours = endTime!.difference(startTime!).inHours;
    final differenceMinutes = endTime.difference(startTime).inMinutes;
    final differenceSeconds = endTime.difference(startTime).inSeconds;
    String totalHours = '$diffenceHours:$differenceMinutes:$differenceSeconds';
    task.totalHours = totalHours;
    await tasks.doc(task.id).update({"totalHours": totalHours});
  }

  static Future createOccurrenceTask(String occurrence, Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    await tasks.doc(task.id).update({"occurrence": occurrence});
    task.occurrence = occurrence;
  }
}
