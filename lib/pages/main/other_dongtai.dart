import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/User.dart';
import 'package:xiaoheiqun/pages/main/dongtai_list.dart';
import 'package:xiaoheiqun/pages/main/other_dongtai_list.dart';

class otherDongtai extends StatefulWidget {
  String id;
  otherDongtai(this.id);
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
    initView();
  }

  var userId;
  User user;
  Future initView() async {
    userId = await Tinker.getuserID();
    var fromId;
    fromId = widget.id;
    Tinker.queryUserInfo(fromId, (data) {
      setState(() {
        user = User.fromJson(data);
      });
      print("ccc");
      print(data);
    });
  }

  var _control;
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;

    final width = size.width;
    return Material(
      child: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                brightness: Brightness.dark,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  user.userName,
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
                child: SafeArea(
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
                                        color:
                                            Color.fromRGBO(238, 238, 238, 1)))),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: ClipOval(
                                        child: Image.network(
                                          "http://imgs.jiashilan.com/" +
                                              user.headImg,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      margin:
                                          EdgeInsets.only(right: 10, top: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.6)),
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
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      ),
                                      left: 34,
                                      top: 38,
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
                                          user.userName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                            Text(user.age.toString() + "岁")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: user.sex == "1"
                                            ? Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Image.asset(
                                                      "image/male@2x.png",
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                  ),
                                                  Text("男")
                                                ],
                                              )
                                            : Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Image.asset(
                                                      "image/female@2x.png",
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                  ),
                                                  Text("女")
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
                            other_dongtai_list(widget.id, 2),
                            other_dongtai_list(widget.id, 3),
                            other_dongtai_list(widget.id, 4)
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
                )),
              )),
    );
  }
}
