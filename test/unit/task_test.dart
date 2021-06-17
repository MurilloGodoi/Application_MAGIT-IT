import 'package:flutter_test/flutter_test.dart';
import 'package:magit/models/task.dart';

void main() {
  final Task task = Task(
        1,
        1,
        0,
        0,
        'Limpar a ferrari',
        'Limpar o carro direitinho',
        'Quintal',
        '27/12/2000',
        '19:30',
        'images/carro.jpg',
        '0');
  test('Should return the userId when create task', () {
    expect(task.userId, 1);
  });

  test('Should return the active when create task', () {
    expect(task.active, 1);
  });

  test('Should return the paused when create task', () {
    expect(task.paused, 0);
  });

  test('Should return the initiated when create task', () {
    expect(task.initiated, 0);
  });

  test('Should return the title when create task', () {
    expect(task.title, 'Limpar a ferrari');
  });

  test('Should return the subtitle when create task', () {
    expect(task.subtitle, 'Limpar o carro direitinho');
  });

  test('Should return the housePlace when create task', () {
    expect(task.housePlace, 'Quintal');
  });

  test('Should return the assignedDate when create task', () {
    expect(task.assignedDate, '27/12/2000');
  });

  test('Should return the assignedTime when create task', () {
    expect(task.assigedTime, '19:30');
  });

  test('Should return the imagePath when create task', () {
    expect(task.imagePath, 'images/carro.jpg');
  });

  test('Should return the totalHours when create task', () {
    expect(task.totalHours, '0');
  });
}
