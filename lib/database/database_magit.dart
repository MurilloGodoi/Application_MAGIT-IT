import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'magit.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE users('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'name TEXT NOT NULL UNIQUE,'
          'email TEXT NOT NULL UNIQUE,'
          'password TEXT NOT NULL);'
          'CREATE TABLE tasks('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'userId INTEGER NOT NULL,'
          'active BOOLEAN NOT NULL,'
          'paused BOOLEAN NOT NULL,'
          'title TEXT NOT NULL,'
          'subtitle TEXT NOT NULL,'
          'housePlace TEXT NOT NULL,'
          'assignedDate DATETIME NOT NULL,'
          'startTime DATETIME,'
          'endTime DATETIME,'
          'auxTime DATETIME,'
          'totalHours DECIMAL(10,5),'
          'occurrence TEXT,'
          'FOREIGN KEY (userId) REFERENCES users (id));');
    },
    version: 1,
  );
}
