import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'magit.db'),
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL)''');
      await db.execute('''CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER NOT NULL,
          active INTEGER NOT NULL,
          paused INTEGER NOT NULL,
          initiated INTEGER NOT NULL,
          title TEXT NOT NULL,
          subtitle TEXT NOT NULL,
          housePlace TEXT NOT NULL,
          assignedDate TEXT NOT NULL,
          assignedTime TEXT NOT NULL,
          imagePath TEXT NOT NULL,
          startTime TEXT,
          endTime TEXT,
          auxTime TEXT,
          totalHours TEXT,
          occurrence TEXT,
          FOREIGN KEY (userId) REFERENCES users (id))''');
    },
    version: 1,
  );
}



