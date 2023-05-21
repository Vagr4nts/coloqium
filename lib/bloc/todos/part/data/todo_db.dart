import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'todo.dart';

class TodoDb {
  //this needs to be a singleton
  static final TodoDb _singleton = TodoDb._internal();
  //private internal constructor
  TodoDb._internal();

  factory TodoDb() {
    return _singleton;
  }

  DatabaseFactory dbFactory = databaseFactoryIo;
  final store = intMapStoreFactory.store('todos');
  Database? _database;

  Future get database async {
    if (_database == null) {
      await _openDb().then((db) {
        _database = db;
      });
    }
    return _database;
  }

  Database db() {
    final database = _openDb();
    return database as Database;
  }

  Future<Database> _openDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'todos.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future insertTodo(Todo todo) async {
    await store.add(_database as DatabaseClient, todo.toMap());
  }

  Future updateTodo(Todo todo) async {
    //Finder is a helper for searching a given store
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(_database as DatabaseClient, todo.toMap(), finder: finder);
  }

  Future deleteTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database as DatabaseClient, finder: finder);
  }

  Future deleteAll() async {
    // Clear all records from the store
    await store.delete(_database as DatabaseClient);
  }

  Future<List<Todo>> getTodos() async {
    await database;
    final finder = Finder(sortOrders: [
      SortOrder('priority'),
      SortOrder('id'),
    ]);
    final todosSnapshot = await store.find(_database as DatabaseClient, finder: finder);
    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      //the id is automatically generated
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }
}
