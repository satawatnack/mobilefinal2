import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/friend_model.dart';
import 'package:mobilefinal2/model/user_model.dart';
import 'package:mobilefinal2/ui/todo_page.dart';

import 'home_page.dart';

class FriendPage extends StatefulWidget {
  final User user;
  FriendPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FriendPageState();
  }
}

class FriendPageState extends State<FriendPage> {
  FriendProvider friendPv = FriendProvider();
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    // TODO: implement build
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
                        builder: (context) => HomePage(user: user)));
              },
            ),
            FutureBuilder(
              future: friendPv
                  .loadDatas("https://jsonplaceholder.typicode.com/users"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Friend> friendList = snapshot.data;
                  User myUser = widget.user;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: friendList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${friendList[index].id} : ${friendList[index].name}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("${friendList[index].email}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("${friendList[index].phone}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("${friendList[index].website}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TodoPage(
                                              id: friendList[index].id,
                                              name: friendList[index].name,
                                              user: myUser,
                                            )));
                              },
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