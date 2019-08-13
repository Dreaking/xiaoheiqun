import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SecondScreenState();
  }
}

class SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  var userId, poll = "12", money = "0", friends = "0";
  Future initView() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId});
    Tinker.post("/api/user/findAllFriend", (data1) {
      Tinker.queryUserInfo(userId, (data) {
        setState(() {
          money = data["money"].toString();
          poll = data["poll"];
          friends = data1["size"];
        });
      });
    }, params: param);
  }

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
                        poll,
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
                        money,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.deepOrange,
                        ),
                      ),
                      new Text(
                        "总收益",
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
                        child: new Text("共" + friends + "个"),
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
