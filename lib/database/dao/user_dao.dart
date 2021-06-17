import 'package:magit/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../database_magit.dart';

const String _tableName = 'users';

class UserDao {
  Future create(User user) async {
    try {
      final Database db = await getDatabase();
      Map<String, dynamic> userMap = _toMap(user);
      await db.insert(
        _tableName,
        userMap,
      );
    } catch (error) {
      print(error);
    }
  }

  Map<String, dynamic> _toMap(User user) {
    final Map<String, dynamic> userMap = Map();

    userMap['name'] = user.name;
    userMap['password'] = user.password;
    return userMap;
  }

  Future<List<User>> find(String name, String password) async {
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> results = await db.rawQuery(
          'SELECT * FROM users WHERE name=? and password=? ',
          ['$name', '$password']);
      List<User> users = _toList(results);
      return users;
    } catch (error) {
      print(error);
    }
    return [];
  }

  List<User> _toList(List<Map<String, dynamic>> results) {
    final List<User> users = [];
    for (Map<String, dynamic> result in results) {
      final User user = User(result['name'], result['email']);
      user.id = result['id'];
      users.add(user);
    }
    return users;
  }

  Future clearUsers() async {
    try {
      final Database db = await getDatabase();
      db.rawDelete('DELETE FROM users');
    } catch (error) {}
  }
}
