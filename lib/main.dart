import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final todoList = <String>[];
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void addTodoItem(String item) {
    setState(() {
      todoList.add(item);
      textController.clear();
    });
  }

  void removeTodoItem(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder( 
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeTodoItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Todo'),
                content: TextField(
                  controller: textController,
                  decoration: InputDecoration(hintText: 'Enter item'),
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      final newItem = textController.text.trim();
                      if (newItem.isNotEmpty) {
                        addTodoItem(newItem);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}








