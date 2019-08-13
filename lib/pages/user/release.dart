import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/pages/edit/index.dart';
import 'package:xiaoheiqun/pages/user/release_list.dart';

class release extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return releaseState();
  }
}

class releaseState extends State<release> with TickerProviderStateMixin {
  var _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(display1: TextStyle(color: Colors.black))),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "我的发布",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 18),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    "新增",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => EditIndex()));
              },
            )
          ],
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 40,
              child: TabBar(
                unselectedLabelColor: Colors.black38,
                isScrollable: false,
                unselectedLabelStyle: TextStyle(fontSize: 12),
                indicatorColor: Colors.deepOrange,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: 15),
                labelColor: Colors.black,
                tabs: <Widget>[
                  Text(
                    "已发布",
                  ),
                  Text(
                    "审核中",
                  ),
                  Text("被驳回")
                ],
                controller: _controller,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  release_list("1"),
                  release_list("2"),
                  release_list("3")
                ],
                controller: _controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
