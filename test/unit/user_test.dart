import 'package:flutter_test/flutter_test.dart';
import 'package:magit/models/user.dart';

void main() {
  final user = User('Zezinho239', 'Zezinho123456');
  test('Should return the name when create user', () {
    expect(user.name, 'Zezinho239');
  });

  test('Should return the email when create user', () {
    expect(user.password, 'Zezinho123456');
  });
}
