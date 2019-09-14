import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/main/dongtai_list.dart';
import 'package:xiaoheiqun/pages/shoucang/shoucang.dart';

import 'guanzhu_person.dart';

class ShoucangIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShoucangIndexState();
  }
}

class ShoucangIndexState extends State<ShoucangIndex>
    with TickerProviderStateMixin {
  //初始化方法
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  var _controller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
                child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              height: 50,
              child: TabBar(
                unselectedLabelColor: Colors.black38,
                indicatorWeight: 1,
                isScrollable: false,
//                unselectedLabelStyle: TextStyle(fontSize: 12),
                indicatorColor: Colors.black45,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(fontSize: 15),
                labelColor: Colors.black,
                tabs: <Widget>[
                  Text(
                    "动态",
                  ),
                  Text(
                    "关注人",
                  ),
                ],
                controller: _controller,
              ),
            )),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Container(
                    color: Color.fromRGBO(250, 250, 250, 1),
                    child: shoucangList(),
                  ),
                  Container(
                    child: guanzhuPerson(),
                  ),
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
