import 'dart:async';

import '../data/todo_db.dart';

import '../data/todo.dart';

class TodoBloc {
  TodoDb db = TodoDb();
  List<Todo> listTodos = [];
  TodoBloc() {
    _todosStreamController.stream.listen(returnTodos);
    _insertStreamController.stream.listen(insertTodo);
    _updateStreamController.stream.listen(updateTodo);
    _deleteStreamController.stream.listen(deleteTodo);

  }
  final _todosStreamController = StreamController<List<Todo>>.broadcast();
  final _insertStreamController = StreamController<Todo>();
  final _updateStreamController = StreamController<Todo>();
  final _deleteStreamController = StreamController<Todo>();

  Stream<List<Todo>> get todos => _todosStreamController.stream;
  StreamSink<List<Todo>> get todosSink => _todosStreamController.sink;
  StreamSink<Todo> get insertSink => _insertStreamController.sink;
  StreamSink<Todo> get updateSink => _deleteStreamController.sink;
  StreamSink<Todo> get deleteSink => _updateStreamController.sink;

  Future getTodos() async {
    listTodos = await db.getTodos();
    todosSink.add(listTodos);
  }

  List<Todo> returnTodos(todos) => todos;

  void deleteTodo(Todo todo) => db.deleteTodo(todo).then((value) => getTodos());
  void updateTodo(Todo todo) => db.updateTodo(todo).then((value) => getTodos());
  void insertTodo(Todo todo) => db.insertTodo(todo).then((value) => getTodos());
}
