import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaoheiqun/microMall/my/manageAddress.dart';
import 'package:xiaoheiqun/microMall/my/my_coupon.dart';
import 'package:xiaoheiqun/microMall/my/open_vip/coupon.dart';
import 'package:xiaoheiqun/microMall/my/vip_page.dart';

class MyIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyIndexState();
  }
}

class MyIndexState extends State<MyIndex> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      appBar: PreferredSize(
          child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 10,
            ),
            margin: EdgeInsets.only(
              top: MediaQueryData.fromWindow(window).padding.top,
            ),
            child: Text(
              "商城",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            height: 50,
          ),
          preferredSize: Size(size.width, 50)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: ScreenUtil().setWidth(1080),
              height: ScreenUtil().setHeight(310),
              child: Row(
                children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.only(left: ScreenUtil().setWidth(70))),
                  ClipOval(
                    child: Image.asset(
                      "image/img5.png",
                      width: ScreenUtil().setWidth(179),
                      height: ScreenUtil().setWidth(179),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30))),
                  Text("雨名无")
                ],
              ),
            ), //头像名称
            Padding(padding: EdgeInsets.only(top: 10)),
            Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(38),
                          horizontal: ScreenUtil().setWidth(40)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.add_location),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(40))),
                                    Text("管理地址")
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => manageAddress()));
                  },
                ), //管理地址
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(38),
                          horizontal: ScreenUtil().setWidth(40)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.view_compact),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(40))),
                                    Text("会员卡")
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => vip_page()));
                  },
                ), //会员卡
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(38),
                          horizontal: ScreenUtil().setWidth(40)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.local_activity),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(40))),
                                    Text("我的优惠卷")
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => my_Coupon()));
                  },
                ), //我的优惠卷
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                Container(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(38),
                        horizontal: ScreenUtil().setWidth(40)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.headset),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(40))),
                                  Text("联系客服")
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.black12,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ), //联系客服
              ],
            )
          ],
        ),
      ),
    );
  }
}
