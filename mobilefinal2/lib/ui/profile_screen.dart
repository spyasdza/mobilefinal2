import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../db/user.dart';
import '../current/current_user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  Future<String> get getPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get getFile async {
    final path = await getPath;
    return File('$path/data.txt');
  }

  Future<File> writeQuote(String data) async {
    final file = await getFile;
    await file.writeAsString('${data}');
  }

  UserDB user = UserDB();
  final _formkey = GlobalKey<FormState>();
  final userid = TextEditingController(text: CurrentUser.userId);
  final name = TextEditingController(text: CurrentUser.name);
  final age = TextEditingController(text: CurrentUser.age);
  final password = TextEditingController();
  final quote = TextEditingController(text: CurrentUser.quote);

  bool isUserIn = false;

  bool isNumeric(String isValueNum) {
    if (isValueNum == null) {
      return false;
    }
    return double.parse(isValueNum) != null;
  }

  int findSpace(String findValueSpace) {
    int count = 0;
    for (int i = 0; i < findValueSpace.length; i++) {
      if (findValueSpace[i] == ' ') {
        count += 1;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "User Id",
                    ),
                    controller: userid,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (isUserIn) {
                        return "User Id is incorrect";
                      } else if (value.length < 6 || value.length > 12) {
                        return "User Id is duplicate";
                      }
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    controller: name,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (findSpace(value) != 1) {
                        return "Name is incorrect";
                      }
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Age",
                    ),
                    controller: age,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill Age";
                      } else if (!isNumeric(value) ||
                          int.parse(value) < 10 ||
                          int.parse(value) > 80) {
                        return "Please fill Age correctly";
                      }
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty || value.length <= 6) {
                        return "Password is incorrect";
                      }
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Quote",
                      contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    controller: quote,
                    keyboardType: TextInputType.text,
                    maxLines: 5),
                RaisedButton(
                    child: Text("SAVE"),
                    onPressed: () async {
                      await user.open("user.db");
                      Future<List<User>> allUser = user.getAllUser();
                      User userData = User();
                      userData.id = CurrentUser.id;
                      userData.userid = userid.text;
                      userData.name = name.text;
                      userData.age = age.text;
                      userData.password = password.text;
                      userData.quote = quote.text;
                      writeQuote(userData.quote);
                      Future isUserTaken(User user) async {
                        var allUsers = await allUser;
                        for (var i = 0; i < allUsers.length; i++) {
                          if (user.userid == allUsers[i].userid &&
                              CurrentUser.id != allUsers[i].id) {
                            this.isUserIn = true;
                            break;
                          }
                        }
                      }

                      if (_formkey.currentState.validate()) {
                        await isUserTaken(userData);
                        if (!this.isUserIn) {
                          await user.updateUser(userData);
                          CurrentUser.userId = userData.userid;
                          CurrentUser.name = userData.name;
                          CurrentUser.age = userData.age;
                          CurrentUser.password = userData.password;
                          CurrentUser.quote = userData.quote;
                          Navigator.pop(context);
                        }
                      }
                      this.isUserIn = false;
                    }),
              ]),
        ));
  }
}