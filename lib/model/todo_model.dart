import 'package:http/http.dart' as http;
import 'dart:convert';

class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo({this.userId, this.id, this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return new Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TodoList {
  List<Todo> myTodo;
  TodoList({
    this.myTodo,
  });
  factory TodoList.fromJson(List<dynamic> parsedJson) {
    List<Todo> myTodo = new List<Todo>();
    myTodo = parsedJson.map((i) => Todo.fromJson(i)).toList();
    return new TodoList(
      myTodo: myTodo,
    );
  }
}

class MyTodoProvider {
  Future<List<Todo>> loadDatas(String url) async {
    print(url);
    http.Response response = await http.get(url);
    final data = json.decode(response.body);
    TodoList todoList = TodoList.fromJson(data);
    print('len: ${todoList.myTodo.length}');
    return todoList.myTodo;
  }
}
