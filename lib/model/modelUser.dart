// import 'package:sqflite/sqflite.dart';

// final String tableTodo = "todo";
// final String columnId = "_id";
// final String columnUser = "user";
// final String columnPassword = "password";
// final String columnDone = "done";

// class Todo {
//   int _id;
//   String user;
//   String password;
//   String done;

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = {
//       columnUser: user,
//       columnPassword: password,
//       columnDone: done,
//     };
//     if (_id != null) {
//       map[columnId] = _id;
//     }
//     return map;
//   }

//   Todo();

//   Todo.formMap(Map<String, dynamic> map) {
//     this._id = map[columnId];
//     this.user = map[columnUser];
//     this.password = map[columnPassword];
//     this.done = map[columnDone];
//   }
// }

// class TodoProvider {
//   Database db;

//   Future open(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''
//       create table $tableTodo (
//         $columnId integer primary key autoincrement,
//         $columnUser text not null,
//         $columnPassword text not null,
//         $columnDone text not null
//       )
//       ''');
//     });
//   }

//   Future<Todo> insert(Todo todo) async {
//     todo._id = await db.insert(tableTodo, todo.toMap());
//     return todo;
//   }

//   Future<Todo> getTodo(int id) async {
//     List<Map> maps = await db.query(tableTodo,
//         columns: [columnId, columnUser, columnDone],
//         where: '$columnId = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return new Todo.formMap(maps.first);
//     }
//     return null;
//   }

//   Future<int> delete(int id) async {
//     return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future<int> update(Todo todo) async {
//     return await db.update(tableTodo, todo.toMap(),
//         where: '$columnId = ?', whereArgs: [todo._id]);
//   }

//   Future<List<Todo>> getAllTodos() async {
//     var todo = await db.query(tableTodo, where: '$columnId > "0"');
//     return todo.map((f) => Todo.formMap(f)).toList();
//   }

//   Future<List<Todo>> getAllDoneTodos() async {
//     var todo = await db.query(tableTodo, where: '$columnDone = 1');
//     return todo.map((f) => Todo.formMap(f)).toList();
//   }

//   Future<void> deleteAllDoneTodo() async {
//     await db.delete(tableTodo, where: '$columnDone = 1');
//   }

//   Future close() async => db.close();
// }

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnUsername = 'username';
final String columnPassword = 'password';

class Todo {
  int _id;
  String _username;
  String _password;
  int _done;

  Todo.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
  }

  Map<String, dynamic> toMap() {
    // map data between _username and _done as Map
    Map<String, dynamic> map = {
      columnUsername: _username,
      columnPassword: _password,
    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  Todo.getValue(username, password) {
    // Get value from addItemScreen
    this._username = username;
    this._password = password;
  }

  Todo.map(dynamic obj) {
    // Map Object to varlable
    this._id = obj['id'];
    this._username = obj['username'];
    this._password = obj['password'];
  }

  // getter and setter
  int get id => _id;
  String get username => _username;
  String get password => _password;

  Todo(); // constructor
}

class TodoDatabase {
  static final TodoDatabase _instance = new TodoDatabase.internal();
  factory TodoDatabase() => _instance;
  static Database _db;
  TodoDatabase.internal(); // start Database auto

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableTodo($columnId INTEGER PRIMARY KEY, $columnUsername TEXT,$columnPassword TEXT)');
  }

  Future<int> saveNewTask(Todo todo) async {
    // save naw task from addItemscreen
    var dbClient = await db;
    var result = await dbClient.insert(tableTodo, todo.toMap());
    return result;
  }

  Future<List> getAllTask() async {
    // get data of row done = 0 (not done)
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableTodo,
        columns: [columnId, columnUsername, columnPassword],
        where: '$columnId > ?',
        whereArgs: [0]);
    return result;
  }

  // Future<List> getAllComplete() async {
  //   // get data of row done = 1 (done)
  //   var dbClient = await db;
  //   List<Map> result = await dbClient.query(tableTodo,
  //       columns: [columnId, columnUsername, columnDone],
  //       where: '$columnDone = ?',
  //       whereArgs: [1]);
  //   return result;
  // }

  // Future<int> deleteAllDone() async {
  //   // delete aata of row done = 1 (done)
  //   var dbClient = await db;
  //   return await dbClient
  //       .delete(tableTodo, where: '$columnDone = ?', whereArgs: [1]);
  // }

  Future<int> updateNote(Todo todo) async {
    // update data of column done between 0 and 1 by id
    var dbClient = await db;
    return await dbClient.update(tableTodo, todo.toMap(),
        where: "$columnId = ?", whereArgs: [todo.id]);
  }

  Future close() async {
    // close database (not use)
    var dbClient = await db;
    return dbClient.close();
  }
}
