import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/data/Draft.dart';
import 'package:xiaoheiqun/data/User.dart';
import 'package:xiaoheiqun/pages/edit/index.dart';
import 'package:xiaoheiqun/pages/main/o_person_data.dart';
import 'package:xiaoheiqun/pages/main/other_dongtai.dart';

class udetail extends StatefulWidget {
  String id;
  udetail(this.id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }
}

class detailState extends State<udetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leftFontSize = 12;
    getData();
  }

  double leftFontSize;
  var guanzhu = "未关注";
  var guanzhu_sel = 0;
  var shoucang;
  var shoucang_sel;
  List movies;
  Animate animate1;
  String merchanId;
  User Muser;
  Draft draft;
  Future getData() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({
      "userId": userId,
      "productId": widget.id,
    });
    Tinker.post("api/product/findProductMessage", (data) {
      setState(() {
        Map<String, dynamic> user = data["rows"];
        merchanId = data["rows"]["merchantId"];
        animate1 = Animate.fromJson(user);
        draft = Draft.fromJson(user);
        print(draft.img);
        print("aazzzz");
        if (data["rows"]["isMShoucang"]) {
          guanzhu_sel = 1;
          guanzhu = "已关注";
        } else {
          guanzhu = "未关注";
          guanzhu_sel = 0;
        }
        if (data["rows"]["isShoucang"]) {
          setState(() {
            shoucang_sel = 1;
            shoucang = "已收藏";
          });
        } else {
          setState(() {
            shoucang_sel = 0;
            shoucang = "未收藏";
          });
        }
      });
      Tinker.queryUserInfo(merchanId, (data) {
        setState(() {
          Muser = User.fromJson(data);
        });
      });
    }, params: param);
  }

  void delDongtai() {
    FormData param = FormData.from({"userId": userId, "productId": widget.id});
    Tinker.post("/api/product/doDeleteProduct", (data) {
      Tinker.toast("删除成功");
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => TinkerScaffold()),
          (route) => route == null);
    }, params: param);
  }

  Future guanzhuMethod() async {
    userId = await Tinker.getuserID();
    FormData param =
        FormData.from({"userId": userId, "merchantId": Muser.userId});
    if (guanzhu_sel == 0) {
      setState(() {
        guanzhu = "已关注";
        guanzhu_sel = 1;
        Tinker.post("/api/system/doShoucangMerchant", () {}, params: param);
        Tinker.toast("关注成功");
      });
    } else {
      setState(() {
        Tinker.post("/api/system/doCancelShoucangMerchant", (data) {
          Tinker.toast("取消关注");
          print(data);
        }, params: param);
        guanzhu_sel = 0;
        guanzhu = "未关注";
      });
    }
  }

  var userId;
  Future shoucangMethod() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from(
        {"userId": userId == null ? "" : userId, "productId": widget.id});
    if (shoucang_sel == 0) {
      setState(() {
        shoucang = "已收藏";
        shoucang_sel = 1;
      });
      Tinker.post("/api/product/doShoucangProduct", (data) {
        Tinker.toast("收藏成功");
      }, params: param);
    } else {
      setState(() {
        shoucang = "未收藏";
        shoucang_sel = 0;
      });
      Tinker.post("/api/product/doCancelShoucangProduct", (data) {
        Tinker.toast("取消收藏");
      }, params: param);
    }
    eventBus.fire(new UserLoggedInEvent("10"));
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    //图片加载
    List<Widget> tupian() {
      List<Container> list = [];
      for (var index = 0; index < animate1.img.length; index++) {
        if (animate1.img[index] == null) {
        } else
          list.add(Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: CachedNetworkImage(
                width: width * 0.3,
//                height: 120,
                fit: BoxFit.fill,
                imageUrl: "http://imgs.jiashilan.com/" + animate1.img[index],
                placeholder: (context, url) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              )));
      }
      return list;
    }

    return Material(
        child: animate1 == null || Muser == null
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                    child: AppBar(
                        brightness: Brightness.dark,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: Text(
                          animate1.merchantName,
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
                            Navigator.pop(context);
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
                              //顶部用户名
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Stack(
                                            children: <Widget>[
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    InkWell(
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            "http://imgs.jiashilan.com/" +
                                                                animate1
                                                                    .headImg,
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 10, top: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12,
                                                                width: 0.6)),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder: (context) =>
                                                                    o_person(
                                                                        animate1
                                                                            .merchantId)));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                height: 60,
                                              ),
                                              Positioned(
                                                child: ClipOval(
                                                  child: Muser.vipType == "1"
                                                      ? Image.asset(
                                                          "image/vipicon.png",
                                                          width: 30,
                                                          height: 30,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : null,
                                                ),
                                                bottom: -8,
                                                left: 30,
                                              ),
                                              Positioned(
                                                child: animate1.isShoucang
                                                    ? Container()
                                                    : Image.asset(
                                                        "image/huangguan.png",
                                                        width: 30,
                                                        height: 16,
                                                        fit: BoxFit.fill,
                                                      ),
                                                top: 0,
                                                left: 10,
                                              )
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                      animate1.merchantName),
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 8),
                                                ),
                                                Container(
                                                  width: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Image.asset(
                                                          "image/vip@2x.png",
                                                          width: 20,
                                                          height: 10,
                                                        ),
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
                                          Container(
                                            child: userId == merchanId
                                                ? null
                                                : GestureDetector(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 20, 0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      193,
                                                                      21,
                                                                      43,
                                                                      1)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      alignment:
                                                          Alignment.center,
                                                      width: 70,
                                                      height: 30,
                                                      child: Text(
                                                        "$guanzhu",
                                                        style: TextStyle(
                                                            fontSize:
                                                                leftFontSize,
                                                            color:
                                                                Color.fromRGBO(
                                                                    193,
                                                                    21,
                                                                    43,
                                                                    1)),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      guanzhuMethod();
                                                    },
                                                  ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              width: 70,
                                              height: 30,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      193, 21, 43, 1),
                                                  border: Border.all(
                                                      color: Color.fromRGBO(
                                                          193, 21, 43, 1)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                userId == merchanId
                                                    ? "我的动态"
                                                    : "看他动态",
                                                style: TextStyle(
                                                    fontSize: leftFontSize,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          otherDongtai(animate1
                                                              .merchantId)));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                      animate1.clickCount.toString(),
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 8, right: 2),
                                      child: Image.asset(
                                        "image/shijian@2x.png",
                                        width: 13,
                                        height: 13,
                                      ),
                                    ),
                                    Text(
                                      animate1.createTime,
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
                                  children: tupian(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: SafeArea(
                              child: userId == merchanId
                                  ? Container(
                                      height: 40,
                                      width: width,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              color: Color.fromRGBO(
                                                  255, 188, 1, 1),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  InkWell(
                                                    child: Container(
                                                      child: Text(
                                                        "删除",
                                                        style: TextStyle(
                                                            fontSize:
                                                                leftFontSize,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                    ),
                                                    onTap: () {
                                                      delDongtai();
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              child: Container(
                                                color: Color.fromRGBO(
                                                    234, 6, 59, 1),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        "编辑",
                                                        style: TextStyle(
                                                            fontSize:
                                                                leftFontSize,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            EditIndex(draft)));
                                              },
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 40,
                                      width: width,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              color: Color.fromRGBO(
                                                  255, 188, 1, 1),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                            fontSize:
                                                                leftFontSize,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                    ),
                                                    onTap: () {
                                                      shoucangMethod();
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              color:
                                                  Color.fromRGBO(234, 6, 59, 1),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                          fontSize:
                                                              leftFontSize,
                                                          color: Colors.white),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    )),
                          bottom: 0,
                        )
                      ],
                    )),
              ));
  }
}
