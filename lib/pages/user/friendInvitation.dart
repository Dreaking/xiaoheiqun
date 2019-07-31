import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(
          '好友邀请',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Text(
                        "O1770PB4",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.deepOrange,
                        ),
                      ),
                      new Text(
                        "我的邀请码",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Text(
                        "O1770PB4",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.deepOrange,
                        ),
                      ),
                      new Text(
                        "我的邀请码",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: double.infinity,
                child: new Container(
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 50,
                      ),
                      new Container(
                        child: new Text(
                          "已邀请",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        width: 70,
                      ),
                      new Container(
                        child: new Text("共0个"),
                        width: 50,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
