import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magit/models/task.dart';
import 'package:magit/models/user.dart';
import 'package:magit/screens/tasks/tasks_details.dart';

void main() {
  final User user = User('Zezinho159', '12345678910');
    final Task task = Task(
        3,
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
  testWidgets('Find card Detalhes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskDetails(user, task),
    ));
    final card = find.text('Detalhes:');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Status', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskDetails(user, task),
    ));
    final card = find.text('Status');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Local', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskDetails(user, task),
    ));
    final card = find.text('Local');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Horário', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskDetails(user, task),
    ));
    final card = find.text('Horário');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Descrição', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskDetails(user, task),
    ));
    final card = find.text('Descrição');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Tempo Gasto', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskDetails(user, task),
    ));
    final card = find.text('Tempo Gasto');
    expect(card, findsOneWidget);
  });
}
