import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/main/dongtai_list.dart';

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
//    return new Container(
//      child: new Container(
//        child: Tinker.Select_Image_picker(
//            Image_height: 120,
//            Image_width: 120,
//            count: 5,
//            line_count: 3,
//            spacing: 13,
//            runSpacing: 10,
//            Click_Image_file: new Image.asset(
//              "image/tianjiatupian.png",
//              width: 120,
//              height: 120,
//              fit: BoxFit.fill,
//            ),
//            callback: (da) {
////              print(da);
//            }),
//      ),
//    );
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
//        appBar: AppBar(
//          title: Text(
//            "我的收藏",
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
                "收藏",
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
                    "动态",
                  ),
                  Text(
                    "关注人",
                  ),
                ],
                controller: _controller,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Container(
                    color: Color.fromRGBO(250, 250, 250, 1),
                    child: DongtaiList(0),
                  ),
                  Column(
                    children: <Widget>[guanzhuPerson()],
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
