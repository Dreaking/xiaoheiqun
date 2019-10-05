import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaoheiqun/microMall/my/open_vip/coupon.dart';

class vip_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return vip_pageState();
  }
}

class vip_pageState extends State<vip_page> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            title: Text(
              "会员卡",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
          preferredSize: Size(size.width, 50)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              "image/top_vip.png",
              width: ScreenUtil().setWidth(1080),
              height: ScreenUtil().setHeight(599),
            ),
            Image.asset(
              "image/center_vip.png",
              width: ScreenUtil().setWidth(1080),
              height: ScreenUtil().setHeight(799),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: ScreenUtil().setWidth(1080),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "--",
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text(
                    "特权详情",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text(
                    "--",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ), //特权详情标题
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(46)),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(20)),
                    child: Text(
                      "600元开卡礼",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ), //开卡礼
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Coupon(), Coupon(), Coupon()],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: ScreenUtil().setWidth(80),
                      runSpacing: ScreenUtil().setHeight(20),
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(441),
                          height: ScreenUtil().setHeight(246),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "image/discount.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(441),
                          height: ScreenUtil().setHeight(246),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "image/discount.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(441),
                          height: ScreenUtil().setHeight(246),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "image/discount.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(441),
                          height: ScreenUtil().setHeight(246),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "image/discount.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //权益
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: ScreenUtil().setWidth(1080),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "更多权益",
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text(
                          "敬请期待",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ), //更多权益
                  SafeArea(
                      child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    height: 50,
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(20)),
                    child: Text(
                      "立即开通",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )), //立即开通
                ],
              ),
            ), //特权详情
          ],
        ),
      ),
    );
  }
}
