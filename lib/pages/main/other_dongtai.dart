import 'package:flutter/material.dart';

import 'dongtai_list.dart';

class otherDongtai extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return otherDongtaiState();
  }
}

class otherDongtaiState extends State<otherDongtai>
    with TickerProviderStateMixin {
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
    _control = TabController(length: 3, vsync: this);
    leftFontSize = 12;
  }

  var _control;
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;

    final width = size.width;
    return SafeArea(
        child: Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "叶落花开",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1)))),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  "image/nologin@2x.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "image/vipicon.png",
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.fill,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                left: 20,
                                top: 20,
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "叶落花开",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  margin: EdgeInsets.only(right: 5),
                                ),
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
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "image/age@2x.png",
                                          width: 10,
                                          height: 10,
                                        ),
                                        margin: EdgeInsets.only(right: 5),
                                      ),
                                      Text("20岁")
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "image/male@2x.png",
                                          width: 10,
                                          height: 10,
                                        ),
                                        margin: EdgeInsets.only(right: 5),
                                      ),
                                      Text("男")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: TabBar(
                      unselectedLabelColor: Colors.black38,
                      isScrollable: false,
                      unselectedLabelStyle: TextStyle(fontSize: 12),
                      indicatorColor: Colors.deepOrange,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: TextStyle(fontSize: 15),
                      labelColor: Colors.black,
                      tabs: <Widget>[
                        Text(
                          "热门",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("点击量"),
                        Text("发布时间")
                      ],
                      controller: _control,
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                    children: <Widget>[
                      DongtaiList(0),
                      Icon(Icons.home),
                      Icon(Icons.print)
                    ],
                    controller: _control,
                  ))
                ],
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
                                    } else {
                                      shoucang = "未收藏";
                                      shoucang_sel = 0;
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
          ),
        ),
      ),
    ));
  }
}
