import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/user_model.dart';
import 'package:mobilefinal2/ui/friend_page.dart';
import 'package:mobilefinal2/ui/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  SharedPreferences sprefer;
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  title: Text('HELLO ${user.name}',
                      style: new TextStyle(fontSize: 20)),
                  subtitle: Text('this is my quote  "${user.quote}"'),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      child: Text('PROFILE SETUP'),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(user: user)));
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      child: Text('My FRIENDS'),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendPage(user: user)));
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      child: Text('SIGN OUT'),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/');
                        sprefer = await SharedPreferences.getInstance();
                        sprefer.setString("username", null);
                        sprefer.setString("password", null);
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
