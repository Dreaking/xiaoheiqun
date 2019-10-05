import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaoheiqun/microMall/home/details/DetailsExplain.dart';
import 'package:xiaoheiqun/microMall/home/details/DetailsTopArea.dart';
import 'package:xiaoheiqun/microMall/home/details/DetailsWeb.dart';
import 'package:xiaoheiqun/microMall/order/orderSettlement.dart';

class productDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return productDetailsState();
  }
}

class productDetailsState extends State<productDetails> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 2340)..init(context);
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return Material(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        appBar: PreferredSize(
            child: AppBar(
              elevation: 0,
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 18,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                "商品详情",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ),
            preferredSize: Size(size.width, 50)),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                //顶部轮播空间
                DetailsTopArea(),
                //选择评价服务中间操作
                DetailsExplain(),
                //商品详情
                DetailsWeb()
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Colors.black12))),
                  width: ScreenUtil().setWidth(1080),
                  height: ScreenUtil().setHeight(150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(Icons.home), Text("返回首页")],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Icon(Icons.add_shopping_cart),
                              Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 10,
                                    alignment: Alignment.center,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ))
                            ],
                          ),
                          Text("购物车")
                        ],
                      ),
                      Container(
                        height: ScreenUtil().setHeight(100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              width: ScreenUtil().setWidth(300),
                              child: Text(
                                "加入购物车",
                                style: TextStyle(color: Colors.white),
                              ),
                              alignment: Alignment.center,
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                width: ScreenUtil().setWidth(300),
                                child: Text("立即购买",
                                    style: TextStyle(color: Colors.white)),
                                alignment: Alignment.center,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            orderSettlement()));
                              },
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
