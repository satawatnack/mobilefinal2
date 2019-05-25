import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/todo_model.dart';
import 'package:mobilefinal2/model/user_model.dart';
import 'package:mobilefinal2/ui/friend_page.dart';

class TodoPage extends StatefulWidget {
  final int id;
  String name;
  final User user;
  TodoPage({Key key, this.id, this.name, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TodoPageState();
  }
}

class TodoPageState extends State<TodoPage> {
  MyTodoProvider todoPv = MyTodoProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int id = widget.id;
    String name = widget.name;
    User user = widget.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('BACK'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendPage(
                              user: user,
                            )));
              },
            ),
            FutureBuilder(
              future: todoPv.loadDatas(
                  "https://jsonplaceholder.typicode.com/todos?userId=$id"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Todo> todoList = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${todoList[index].id}",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("${todoList[index].title}",
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "${todoList[index].completed}" == "true"
                                          ? "Completed"
                                          : "",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }else {
                  return Center(
                    child: Text("..."),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
