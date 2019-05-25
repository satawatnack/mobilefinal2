import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobilefinal2/ui/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TodoProvider user = TodoProvider();
  List<User> allUser = new List();
  SharedPreferences sPrefer;
  String sUsername;
  String sPassword;

  @override
  void initState() {
    super.initState();
    user.openDB().then((open) {
      getAllUser();
    });
  }

  void getAllUser() {
    user.getAllUser().then((myList) async{
      allUser = myList;
      print(allUser.length);
      sPrefer = await SharedPreferences.getInstance();
      sUsername = sPrefer.getString('username');
      sPassword = sPrefer.getString('password');
      for (int i = 0; i < allUser.length; i++) {
        if (allUser[i].userId == sUsername &&
            allUser[i].password == sPassword) {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (context) => HomePage(user: allUser[i])));
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: ListView(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Image.network(
                "https://www.baanandbeyond.com/media/catalog/product/cache/image/550x/beff4985b56e3afdbeabfc89641a4582/6/0/60008182.jpg",
                height: 250,
              ),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  hintText: "User Id",
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value.isEmpty) return "Please fill out this form";
                },
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value.isEmpty) return "Please fill out this form";
                },
                obscureText: true,
              ),
              RaisedButton(
                child: Text("LOGIN"),
                onPressed: () async {
                  int check = 0;
                  if (_formKey.currentState.validate()) {
                    for (int i = 0; i < allUser.length; i++) {
                      if (allUser[i].userId == username.text &&
                          allUser[i].password == password.text) {
                        sPrefer = await SharedPreferences.getInstance();
                        sPrefer.setString("username", allUser[i].userId);
                        sPrefer.setString("password", allUser[i].password);
                        check = 1;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(user: allUser[i])));
                      }
                    }
                    if (username.text.length > 0 &&
                        password.text.length > 0 &&
                        check == 0) {
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alert"),
                            content:
                                const Text("username or password ไม่ถูกต้อง"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
              FlatButton(
                child: SizedBox(
                    width: double.infinity,
                    child: Text("Register New Account",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.blue))),
                onPressed: () {
                  Navigator.pushNamed(context, "/register_page");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
