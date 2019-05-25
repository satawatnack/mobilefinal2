import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/user_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  List<User> allUser = new List();
  TodoProvider user = TodoProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController regis_userId = TextEditingController();
  TextEditingController regis_password = TextEditingController();
  TextEditingController regis_name = TextEditingController();
  TextEditingController regis_age = TextEditingController();
  @override
  void initState() {
    super.initState();
    user.openDB().then((open) {
      getAllUser();
    });
  }

  void getAllUser() {
    user.getAllUser().then((myList) {
      setState(() {
        allUser = myList;
        print(allUser.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            TextFormField(
              controller: regis_userId,
              decoration: InputDecoration(
                  hintText: "User Id",
                  icon: Icon(Icons.person)),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
                if (value.length < 6 || value.length > 12)
                  return "userId ต้องมีความยาว 6-12 ตัว";
                for (int i = 0; i < allUser.length; i++) {
                  if (allUser[i].userId == value) return "ID นี้มีผู้ใช้แล้ว";
                }
              },
            ),
            TextFormField(
              controller: regis_name,
              decoration: InputDecoration(
                  hintText: "Name",
                  icon: Icon(Icons.person_pin)),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                int have = 0;
                for (int i = 0; i < value.length; i++) {
                  if (value[i] == " ") have += 1;
                }
                if (value.isEmpty)
                  return "Please fill out this form";
                else if (have != 1) return "ต้องเป็น : Firstname Lastname";
              },
            ),
            TextFormField(
              controller: regis_age,
              decoration: InputDecoration(
                  hintText: "Age", icon: Icon(Icons.date_range)),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty)
                  return "Please fill out this form";
                else if (int.parse(value) < 10 || int.parse(value) > 80)
                  return "ต้องอยู่ในช่วง 10-80";
              },
            ),
            TextFormField(
              controller: regis_password,
              decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock)),
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
                if (value.length <= 6) return "password ต้องมากกว่า 6 ตัว";
              },
              obscureText: true,
            ),
            RaisedButton(
              child: Text("CONTINUE"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  User data = User(
                      userId: regis_userId.text,
                      password: regis_password.text,
                      name: regis_name.text,
                      age: int.parse(regis_age.text));
                  user.insert(data).then((result) {
                    print('insert');
                    Navigator.pushNamed(context, '/');
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
