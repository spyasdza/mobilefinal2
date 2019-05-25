import 'package:flutter/material.dart';

class RegisScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return RegisScreenState();
  }

}

class RegisScreenState extends State<RegisScreen> {
  final _formKey = GlobalKey<FormState>();
  String user_email, user_pass1, user_pass2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register")
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Enter email here",
                hintText: "Email",
                icon: Icon(Icons.email),
              ),

              keyboardType: TextInputType.emailAddress,

              validator:  (email){
                if(email.isEmpty){
                  user_email = "";
                  return "กรุณาระบุข้อมูลให้ครบถ้วน";
                }
                else{
                  user_email = email;
                }
              }
            ),

            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter password here",
                hintText: "Password",
                icon: Icon(Icons.lock),
              ),

              keyboardType: TextInputType.text,

              validator:  (pass){
                if(pass.isEmpty){
                  user_pass1 = "";
                  return "กรุณาระบุข้อมูลให้ครบถ้วน";
                }
                else{
                  user_pass1 = pass;
                }
              }
            ),

            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                hintText: "Confirm Password",
                icon: Icon(Icons.lock),
              ),

              keyboardType: TextInputType.text,

              validator:  (id){
                if(id.isEmpty){
                  user_pass2 = "";
                  return "กรุณาระบุข้อมูลให้ครบถ้วน";
                }
                else{
                  user_pass2 = id;
                }
              }
            ),

            RaisedButton(
              child: Text("Continue"),
              color: Colors.green[50],
              onPressed: (){
                _formKey.currentState.validate();
                if(user_email == "admin"){
                  _ackAlert3(context);
                }
                else if(user_pass1 != user_pass2){
                  _ackAlert2(context);
                }
                else if(user_email == "" || user_pass1 == "" || user_pass2 == ""){
                  _ackAlert1(context);
                }
                else{
                  Navigator.pushNamed(context, "/");
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _ackAlert2(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Password mismatch'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ackAlert1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('กรุณาระบุข้อมูลให้ครบถ้วน'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ackAlert3(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('User นี้มีอยู่ในระบบแล้ว'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
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