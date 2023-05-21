import 'package:flutter/material.dart';
import 'data/todo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [
    Todo('name1', 'description1', 'Sam', 0),
    Todo('name2', 'description2', 'John', 0),
    Todo('name3', 'description3', 'Michael', 0),
    Todo('neme4', 'description4', 'Mary', 0)
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          backgroundColor: Colors.amber,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: ValueKey(todos[index]),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).highlightColor,
                      child: Text("${todos[index].priority}"),
                    ),
                    title: Text(todos[index].name),
                    subtitle: Text(todos[index].description),
                  ));
            }));
  }
}
