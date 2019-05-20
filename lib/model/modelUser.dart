import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnUsername = 'username';
final String columnPassword = 'password';
final String columnCheck = 'check';
final String columnYear = 'year';
final String columnGender = 'gender';
final String columnDate = 'date';

class Todo {
  int _id;
  String _username;
  String _password;
  String _check;
  String _year;
  String _gender;
  String _date;

  Todo.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
    this._check = map['check'];
    this._year = map['year'];
    this._gender = map['gender'];
    this._date = map['date'];
  }

  Map<String, dynamic> toMap() {
    // map data between _username and _done as Map
    Map<String, dynamic> map = {
      columnUsername: _username,
      columnPassword: _password,
      columnCheck: _check,
      columnYear: _year,
      columnGender: _gender,
      columnDate: _date
    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  Todo.getValue(username, password, check, year, gender, date) {
    // Get value from addItemScreen
    this._username = username;
    this._password = password;
    this._check = check;
    this._year = year;
    this._gender = gender;
    this._date = date;
  }

  Todo.map(dynamic obj) {
    // Map Object to varlable
    this._id = obj['id'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._check = obj['check'];
    this._year = obj['year'];
    this._gender = obj['gender'];
    this._date = obj['date'];
  }

  // getter and setter
  int get id => _id;
  String get username => _username;
  String get password => _password;
  String get check => _check;
  String get year => _year;
  String get gender => _gender;
  String get date => _date;

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
        'CREATE TABLE $tableTodo($columnId INTEGER PRIMARY KEY, $columnUsername TEXT,$columnPassword TEXT,$columnCheck TEXT,$columnYear TEXT,$columnGender TEXT,$columnDate TEXT)');
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
        columns: [
          columnId,
          columnUsername,
          columnPassword,
          columnCheck,
          columnYear,
          columnGender,
          columnDate
        ],
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
