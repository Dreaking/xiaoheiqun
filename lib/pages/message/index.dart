import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/pages/message/systen_message.dart';
import 'package:xiaoheiqun/pages/message/test.dart';

class MessageIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessageIndexState();
  }
}

class MessageIndexState extends State<MessageIndex>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  var _controller;
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
//        appBar: AppBar(
//          brightness: Brightness.light,
//          title: Text(
//            "消息",
//            style: TextStyle(color: Colors.black, fontSize: 22),
//          ),
//          elevation: 0,
//          backgroundColor: Colors.white,
//        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: Text(
                "消息",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.fromLTRB(15, 30, 0, 0),
            ),
            Container(
              height: 50,
              child: TabBar(
                unselectedLabelColor: Colors.black38,
                isScrollable: false,
//                unselectedLabelStyle: TextStyle(fontSize: 12),
                indicatorColor: Colors.deepOrange,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: 15),
                labelColor: Colors.black,
                tabs: <Widget>[
                  Text(
                    "我的消息",
                  ),
                  Text(
                    "系统消息",
                  ),
                ],
                controller: _controller,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Container(
                    child: Text(
                      "暂无数据",
                      style: TextStyle(fontSize: 16),
                    ),
                    alignment: Alignment.center,
                  ),
                  systemMsg()
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
