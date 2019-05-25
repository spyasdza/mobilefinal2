import 'package:flutter/material.dart';

class MyFriendScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 5,
        child: new Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Home"),
            backgroundColor: Colors.black,
          ),
          body: TabBarView(
            children: <Widget>[
              new Container(
                color: Colors.pink[50],
                alignment: FractionalOffset.center,
                child: Text("Home"),
              ),
              new Container(
                color: Colors.orange[50],
                alignment: FractionalOffset.center,
                child: Text("Notify"),
              ),
              new Container(
                color: Colors.lightGreen[50],
                alignment: FractionalOffset.center,
                child: Text("Map"),
              ),
              new Container(
                color: Colors.red[50],
                alignment: FractionalOffset.center,
                child: Text("Proﬁle"),
              ),
              new Container(
                color: Colors.yellow[50],
                alignment: FractionalOffset.center,
                child: Text("Setup"),
              ),
            ],
          ),

          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.notifications),
              ),
              Tab(
                icon: new Icon(Icons.map),
              ),
              Tab(
                icon: new Icon(Icons.person),
              ),
              Tab(
                icon: new Icon(Icons.settings),
              ),
            ],
            indicatorColor: Colors.yellow,
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.grey,
        ),
      ),
    );
  }
}