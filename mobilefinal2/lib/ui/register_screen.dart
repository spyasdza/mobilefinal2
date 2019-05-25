import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../db/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  UserDB user = UserDB();
  final _formkey = GlobalKey<FormState>();
  final userid = TextEditingController();
  final name = TextEditingController();
  final age = TextEditingController();
  final password = TextEditingController();
  final quote = "";
  bool userIn = false;

  bool isNumeric(String isValueNum) {
    if (isValueNum == null) {
      return false;
    }
    return double.parse(isValueNum) != null;
  }

  int findSpace(String findValueSpace) {
    int result = 0;
    for (int i = 0; i < findValueSpace.length; i++) {
      if (findValueSpace[i] == ' ') {
        result += 1;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
                  hintText: "User Id",
                  icon: Icon(Icons.person),
                ),
                controller: userid,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill out this form";
                  } else if (value.length < 6 || value.length > 12) {
                    return "User Id is incorrect";
                  } else if (this.userIn) {
                    return "User Id is duplicate";
                  }
                }),
            TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                  icon:
                      Icon(Icons.account_circle),
                ),
                controller: name,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill out this form";
                  }
                  if (findSpace(value) != 1) {
                    return "Name is incorrect";
                  }
                }),
            TextFormField(
                decoration: InputDecoration(
                  hintText: "Age",
                  icon: Icon(Icons.event_note),
                ),
                controller: age,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill out this form";
                  } else if (!isNumeric(value) ||
                      int.parse(value) < 10 ||
                      int.parse(value) > 80) {
                    return "Age is incorrect";
                  }
                }),
            TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock),
                ),
                controller: password,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty || value.length <= 6) {
                    return "Password is incorrect";
                  }
                }),
                
            RaisedButton(
                child: Text("REGISTER NEW ACCOUNT"),
                onPressed: () async {
                  await user.open("user.db");
                  Future<List<User>> allUser = user.getAllUser();
                  User userData = User();
                  userData.userid = userid.text;
                  userData.name = name.text;
                  userData.age = age.text;
                  userData.password = password.text;
                  userData.quote = quote;

                  Future isNewUserIn(User user) async {
                    var allUsers = await allUser;
                    for (var i = 0; i < allUsers.length; i++) {
                      if (user.userid == allUsers[i].userid) {
                        this.userIn = true;
                        break;
                      }
                    }
                  }

                  await isNewUserIn(userData);

                  if (_formkey.currentState.validate()) {
                    if (!this.userIn) {
                      userid.text = "";
                      name.text = "";
                      age.text = "";
                      password.text = "";
                      await user.insertUser(userData);
                      Toast.show("Create Success", context,
                        duration: Toast.LENGTH_LONG);
                      Navigator.pop(context);
                    }
                  }
                  this.userIn = false;
                }),
          ],
        ),
      ),
    );
  }
}