import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableUser = "user";
final String columnId = "id";
final String columnUserId = "userId";
final String columnName = "name";
final String columnAge = "age";
final String columnPassword = "password";
final String columnQuote = "quote";

class User {
  int id;
  String userId;
  String name;
  int age;
  String password;
  String quote;

  User(
      {int id,
      String userId,
      String name,
      int age,
      String password,
      String quote}) {
    this.id = id;
    this.userId = userId;
    this.name = name;
    this.age = age;
    this.password = password;
    this.quote = quote;
  }
  factory User.fromMap(Map<String, dynamic> map) => new User(
      id: map[columnId],
      userId: map[columnUserId],
      name: map[columnName],
      age: map[columnAge],
      password: map[columnPassword],
      quote: map[columnQuote]);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUserId: userId,
      columnName: name,
      columnAge: age,
      columnPassword: password,
      columnQuote: quote
    };
    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }
}

class TodoProvider {
  static final TodoProvider db = TodoProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await openDB();
      return _database;
    }
  }

  Future openDB() async {
    var dbpath = await getDatabasesPath();
    String path = dbpath + "\todo.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database _database, int version) async {
      await _database.execute(
          '''create table $tableUser ($columnId integer primary key autoincrement, $columnUserId text not null, $columnName text, $columnAge integer, $columnPassword text not null, $columnQuote text)''');
    });
  }

  Future<List<User>> getAllUser() async {
    final _database = await database;
    var result = await _database.query(tableUser);
    List<User> list = result.map((d) => User.fromMap(d)).toList();
    return list;
  }

  // Future<List<Todo>> getAllTodoNotDones() async {
  //   final _database = await database;
  //   var result = await _database.query(tableTodo, where: '$columnDone = 0');
  //   List<Todo> list = result.map((d) => Todo.fromMap(d)).toList();
  //   return list;
  // }

  Future<User> insert(User user) async {
    final _database = await database;
    user.id = await _database.insert(tableUser, user.toMap());
    return user;
  }

  // Future<int> deleteDones() async {
  //   final _database = await database;
  //   return _database.delete(tableTodo, where: '$columnDone = 1');
  // }

  Future<int> update(User user) async {
    final _database = await database;
    return _database.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async => _database.close();
}
