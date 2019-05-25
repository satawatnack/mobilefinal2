import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/user_model.dart';
import 'package:mobilefinal2/ui/home_page.dart';


class Profile extends StatefulWidget {
  final User user;
  Profile({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController quote = TextEditingController();
  List<User> allUser = new List();
  TodoProvider user = TodoProvider();

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
    User thisUser = widget.user;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            TextFormField(
              controller: userId,
              decoration: InputDecoration(
                  hintText: "User Id",),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
                if (value.length < 6 || value.length > 12)
                  return "userId ต้องมีความยาว 6-12 ตัว";
              },
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  hintText: "Name",),
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
              controller: age,
              decoration: InputDecoration(
                  hintText: "Age"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty)
                  return "Please fill out this form";
                else if (int.parse(value) < 10 || int.parse(value) > 80)
                  return "ต้องอยู่ในช่วง 10-80";
              },
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  hintText: "Password"),
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
                if (value.length <= 6) return "password ต้องมากกว่า 6 ตัว";
              },
              obscureText: true,
            ),
            TextFormField(
              controller: quote,
              decoration: InputDecoration(hintText: "please input your quote"),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter some text";
                }
              },
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  thisUser.userId = userId.text;
                  thisUser.name = name.text;
                  thisUser.age = int.parse(age.text);
                  thisUser.password = password.text;
                  thisUser.quote = quote.text;
                  user.update(thisUser).then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(user: thisUser)));
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
