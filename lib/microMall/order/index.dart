import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaoheiqun/microMall/order/tabBarView/AllOrder.dart';

class OrderIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderIndexState();
  }
}

class OrderIndexState extends State<OrderIndex> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = new ScreenUtil(
      width: 1080,
      height: 2340,
    )..init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      appBar: PreferredSize(
          child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            margin: EdgeInsets.only(
              top: MediaQueryData.fromWindow(window).padding.top,
            ),
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              "我的订单",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            height: 50,
          ),
          preferredSize: Size(size.width, 50)),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: size.width,
            height: 50,
            child: TabBar(
                labelPadding: EdgeInsets.all(0),
                indicatorSize: TabBarIndicatorSize.label,
                controller: tabController,
                tabs: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          "全部订单",
                        ),
                      ),
                      Positioned(
                          right: 5,
                          top: 10,
                          child: Container(
                            width: 10,
                            height: 10,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "1",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ))
                    ],
                  ),
                  Text("待付款"),
                  Text("待收货"),
                  Text("待评价"),
                  Text("售后")
                ]),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: <Widget>[
              AllOrder(),
              AllOrder(),
              AllOrder(),
              AllOrder(),
              AllOrder(),
            ]),
          )
        ],
      ),
    );
  }
}
