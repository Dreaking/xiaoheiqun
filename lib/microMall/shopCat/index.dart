import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:xiaoheiqun/microMall/home/productDetails.dart';
import 'package:xiaoheiqun/microMall/provide/currentIndex.dart';
import 'package:xiaoheiqun/microMall/shopCat/CheckBox.dart';

class ShopCatIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopCatIndexState();
  }
}

class ShopCatIndexState extends State<ShopCatIndex> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);
    return Scaffold(
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
              "购物车",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            height: 50,
          ),
          preferredSize: Size(size.width, 50)),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setWidth(20),
                        left: ScreenUtil().setWidth(40),
                        right: ScreenUtil().setWidth(40)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("共1件商品"),
                        Text(
                          "管理",
                          style: TextStyle(color: Colors.deepOrange),
                        )
                      ],
                    ),
                  ), //管理
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setWidth(20),
                        left: ScreenUtil().setWidth(40),
                        right: ScreenUtil().setWidth(40)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 18,
                          height: 18,
                          margin: EdgeInsets.only(right: 10),
                          child: CustomerCheckbox(
                            width: 18,
                            isCircle: true,
                            value: isCheck,
                            activeColor: Colors.pink,
                            onChanged: (bool val) {},
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "image/img5.png",
                                fit: BoxFit.cover,
                                width: ScreenUtil().setWidth(200),
                                height: ScreenUtil().setHeight(252),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(40)),
                                width: ScreenUtil().setWidth(605),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Container(
                                        child:
                                            Text("九阳小黄人C905D便携式榨汁机家用小型电动果汁榨汁杯"),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    productDetails()));
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "￥249.00",
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black45),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Provide<CurrentIndexProvide>(
                                            builder: (context, child, val) {
                                              int counts = Provide.value<
                                                          CurrentIndexProvide>(
                                                      context)
                                                  .productCounts;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    child: Container(
                                                      width: 25,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              right: BorderSide(
                                                                  color: Colors
                                                                      .black45))),
                                                      child: Text("-"),
                                                    ),
                                                    onTap: () {
                                                      Provide.value<
                                                                  CurrentIndexProvide>(
                                                              context)
                                                          .delProducts();
                                                    },
                                                  ),
                                                  Container(
                                                    width: 25,
                                                    alignment: Alignment.center,
                                                    child:
                                                        Text(counts.toString()),
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      width: 25,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              left: BorderSide(
                                                                  color: Colors
                                                                      .black45))),
                                                      child: Text("+"),
                                                    ),
                                                    onTap: () {
                                                      Provide.value<
                                                                  CurrentIndexProvide>(
                                                              context)
                                                          .addProducts();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ) //右侧详情
                      ],
                    ),
                  ), //订单
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: ScreenUtil().setWidth(1080),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: CustomerCheckbox(
                                width: 18,
                                isCircle: true,
                                value: isCheck,
                                activeColor: Colors.pink,
                                onChanged: (bool) {
                                  setState(() {
                                    isCheck = bool;
                                  });
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 5)),
                            Text("全选")
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("合计："),
                            Text(
                              "￥249.00",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.deepOrange),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(60),
                                  vertical: ScreenUtil().setWidth(15)),
                              child: Text(
                                "结算(1)",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
