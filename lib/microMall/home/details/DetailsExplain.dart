import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:xiaoheiqun/microMall/home/details/Evaluate.dart';
import 'package:xiaoheiqun/microMall/provide/currentIndex.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provide.value<CurrentIndexProvide>(context).setProductCounts();
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      height: ScreenUtil().setHeight(400),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text("已选:"),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(5)),
                  child: Provide<CurrentIndexProvide>(
                    builder: (context, child, val) {
                      int counts = Provide.value<CurrentIndexProvide>(context)
                          .productCounts;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              width: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right:
                                          BorderSide(color: Colors.black45))),
                              child: Text("-"),
                            ),
                            onTap: () {
                              Provide.value<CurrentIndexProvide>(context)
                                  .delProducts();
                            },
                          ),
                          Container(
                            width: 25,
                            alignment: Alignment.center,
                            child: Text(counts.toString()),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Colors.black45))),
                              child: Text("+"),
                            ),
                            onTap: () {
                              Provide.value<CurrentIndexProvide>(context)
                                  .addProducts();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ), //Row已选
          Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(40))),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 10)),
              Text("服务："),
              Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(60))),
              Image.asset(
                "image/sel_@2x_294.png",
                width: 10,
                height: 10,
              ),
              Text("正品保障"),
              Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(80))),
              Image.asset(
                "image/sel_@2x_294.png",
                width: 10,
                height: 10,
              ),
              Text("无忧售后"),
              Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(80))),
              Image.asset(
                "image/sel_@2x_294.png",
                width: 10,
                height: 10,
              ),
              Text("极速退款")
            ],
          ), //服务
          Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(40))),

          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 10, color: Color.fromRGBO(242, 242, 242, 1)))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text("评价(0)"),
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Evaluate()));
            },
          )
        ],
      ),
    );
  }
}
