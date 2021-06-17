import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magit/models/user.dart';
import 'package:magit/screens/menu/menu.dart';

void main() {
  final User user = User('Zezinho159', '12345678910');
  testWidgets('Find card Escolha uma das opções', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Menu(user),
    ));
    final card = find.text('Escolha uma das opções:');
    expect(card, findsOneWidget);
  });
  testWidgets('Find card Tarefas do dia', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Menu(user),
    ));
    final card = find.text('Tarefas do dia');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Informações', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Menu(user),
    ));
    final card = find.text('Informações');
    expect(card, findsOneWidget);
  });

  testWidgets('Find card Configurações', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Menu(user),
    ));
    final cardTasks = find.text('Configurações');
    expect(cardTasks, findsOneWidget);
  });
}
