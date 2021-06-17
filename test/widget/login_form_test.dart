import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magit/screens/login/login_form.dart';

void main() {
  testWidgets('Find mainImage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginForm(),
    ));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Find username input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginForm(),
    ));
    final inputUsername = find.text('Usuário');
    expect(inputUsername, findsOneWidget);
  });

  testWidgets('Find password input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginForm(),
    ));
    final inputPassword = find.text('Senha');
    expect(inputPassword, findsOneWidget);
  });

  testWidgets('Find button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginForm(),
    ));
    final button = find.text('ENTRAR');
    expect(button, findsOneWidget);
  });
}
