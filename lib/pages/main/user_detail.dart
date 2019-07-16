import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xiaoheiqun/common/tinker.dart';

import 'other_dongtai.dart';

class udetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }
}

class detailState extends State<udetail> {
  @override
  double leftFontSize;
  var guanzhu = "未关注";
  var guanzhu_sel = 0;
  var shoucang = "未收藏";
  var shoucang_sel = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leftFontSize = 12;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;

    final width = size.width;
    //顶部用户名
    Widget TopUserName() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Image.asset("image/nologin@2x.png"),
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text("用户-1929"),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        ),
                        Container(
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset(
                                "image/vip@2x.png",
                                width: 20,
                                height: 10,
                              ),
                              Image.asset(
                                "image/renzheng.png",
                                width: 20,
                                height: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromRGBO(193, 21, 43, 1)),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      width: 70,
                      height: 30,
                      child: Text(
                        "$guanzhu",
                        style: TextStyle(
                            fontSize: leftFontSize,
                            color: Color.fromRGBO(193, 21, 43, 1)),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (guanzhu_sel == 0) {
                          guanzhu = "已关注";
                          guanzhu_sel = 1;
                          Tinker.toast("关注成功");
                        } else {
                          guanzhu_sel = 0;
                          guanzhu = "未关注";
                          Tinker.toast("取消关注");
                        }
                      });
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: 70,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(193, 21, 43, 1),
                          border:
                              Border.all(color: Color.fromRGBO(193, 21, 43, 1)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "看他动态",
                        style: TextStyle(
                            fontSize: leftFontSize, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => otherDongtai()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
        child: WillPopScope(
            child: Material(
                child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: Text(
                        "用户-1929",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                      centerTitle: true,
                      leading: InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TinkerScaffold()),
                            (route) => route == null,
                          );
                        },
                      )),
                  preferredSize: Size.fromHeight(45)),
              body: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: Stack(
                    fit: StackFit.loose,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TopUserName(),
                            //浏览
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                                    child: Image.asset(
                                      "image/liulan@2x.png",
                                      width: 15,
                                      height: 10,
                                    ),
                                  ),
                                  Text(
                                    "93",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8, right: 2),
                                    child: Image.asset(
                                      "image/shijian@2x.png",
                                      width: 13,
                                      height: 13,
                                    ),
                                  ),
                                  Text(
                                    "2019-05-05 18:07",
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                            //图片
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    child: Image.asset(
                                      "image/img5.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    child: Image.asset(
                                      "image/img5.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    child: Image.asset(
                                      "image/img5.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: 40,
                          width: width,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: Color.fromRGBO(255, 188, 1, 1),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "image/shoucang3.png",
                                        color: Colors.white,
                                        width: 20,
                                        height: 20,
                                      ),
                                      InkWell(
                                        child: Container(
                                          child: Text(
                                            "$shoucang",
                                            style: TextStyle(
                                                fontSize: leftFontSize,
                                                color: Colors.white),
                                          ),
                                          margin: EdgeInsets.only(left: 10),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (shoucang_sel == 0) {
                                              shoucang = "已收藏";
                                              shoucang_sel = 1;
                                              Tinker.toast("收藏成功");
                                            } else {
                                              shoucang = "未收藏";
                                              shoucang_sel = 0;
                                              Tinker.toast("取消收藏");
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  color: Color.fromRGBO(234, 6, 59, 1),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "image/kefu@2x.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      Container(
                                        child: Text(
                                          "发消息",
                                          style: TextStyle(
                                              fontSize: leftFontSize,
                                              color: Colors.white),
                                        ),
                                        margin: EdgeInsets.only(left: 10),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        bottom: 0,
                      )
                    ],
                  )),
            )),
            onWillPop: () {
              Navigator.pop(context);
//              Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(builder: (context) => TinkerScaffold()),
//                (route) => route == null,
//              );
            }));
  }
}
