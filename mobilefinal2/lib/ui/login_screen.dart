import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/user.dart';
import '../current/current_user.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String haveUser = '';
  

  Future<int> _getIntFromSharedPref() async{

  }

  final _formkey = GlobalKey<FormState>();
  UserDB user = UserDB();
  final userid = TextEditingController();
  final userpassword = TextEditingController();
  bool isValid = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: <Widget>[
            Image.asset(
              "resources/key.jpg",
              height: 200,
            ),
            TextFormField(
                decoration: InputDecoration(
                  hintText: "User Id",
                  icon: Icon(Icons.person),
                ),
                controller: userid,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isNotEmpty) {
                    this.count += 1;
                  }
                }),
            TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock),
                ),
                controller: userpassword,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isNotEmpty) {
                    this.count += 1;
                  }
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            RaisedButton(
              child: Text("LOGIN"),
              onPressed: () async {
                _formkey.currentState.validate();
                await user.open("user.db");
                Future<List<User>> allUser = user.getAllUser();

                Future isValid(String userid, String userpassword) async {
                  var userList = await allUser;
                  for (var i = 0; i < userList.length; i++) {
                    if (userid == userList[i].userid &&
                        userpassword == userList[i].password) {
                      CurrentUser.id = userList[i].id;
                      CurrentUser.userId = userList[i].userid;
                      CurrentUser.name = userList[i].name;
                      CurrentUser.age = userList[i].age;
                      CurrentUser.password = userList[i].password;
                      CurrentUser.quote = userList[i].quote;
                      this.isValid = true;
                      break;
                    }
                  }
                }

                if (this.count != 2) {
                  Toast.show("Please fill out this form", context,
                      duration: Toast.LENGTH_LONG);
                  this.count = 0;
                } else {
                  this.count = 0;
                  await isValid(userid.text, userpassword.text);
                  if (this.isValid) {

                    Navigator.pushReplacementNamed(context, '/home');
                    userid.text = "";
                    userpassword.text = "";
                  } else {
                    Toast.show("Invalid user or password", context,
                        duration: Toast.LENGTH_LONG);
                  }
                }
              },
            ),
            Container(
              alignment: FractionalOffset.bottomRight,
              child: FlatButton(
                child: Container(
                  child: Text("Register New Account", textAlign: TextAlign.right),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}