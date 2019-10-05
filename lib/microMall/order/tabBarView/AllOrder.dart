import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaoheiqun/microMall/order/orderDetails.dart';

class AllOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllOrderState();
  }
}

class AllOrderState extends State<AllOrder> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.white),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("主单编号：9898976756756521"),
                        Text(
                          "交易关闭",
                          style: TextStyle(color: Colors.deepOrange),
                        )
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  Divider(
                    height: 10.0,
                    indent: 0.0,
                    color: Colors.black12,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "子单编号：912309139128390128",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Divider(
                    height: 10.0,
                    indent: 0.0,
                    color: Colors.black12,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "image/img5.png",
                        width: ScreenUtil().setHeight(306),
                        height: ScreenUtil().setHeight(306),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: ScreenUtil().setWidth(630),
                        child: Column(
                          children: <Widget>[
                            Text("九阳小黄人C906D便携式榨汁机家用小型电动果汁机水果榨汁机"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[Text("￥249"), Text("X 1")],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 1.0,
                    indent: 0.0,
                    color: Colors.black12,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("共一件商品 合计："),
                        Text(
                          "￥249",
                          style: TextStyle(color: Colors.deepOrange),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => orderDetails()));
            },
          );
        });
  }
}
