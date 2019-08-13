import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xiaoheiqun/common/KefuDiag.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/user/person_data.dart';
import 'package:xiaoheiqun/pages/user/release.dart';
import 'package:xiaoheiqun/pages/user/settings.dart';
import 'package:xiaoheiqun/login.dart';
import 'authentation_user.dart';
import 'balance.dart';
import 'download.dart';
import 'friendInvitation.dart';
import 'open_vip.dart';

class UserIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserIndexState();
  }
}

class UserIndexState extends State<UserIndex>
    with AutomaticKeepAliveClientMixin {
//监听Bus events
  var _control;
  void _listen() {
    _control = eventBus.on<UserLoggedInEvent>().listen((event) {
      setState(() {
        initView();
      });
    });
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void initState() {
    super.initState();
    initView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _control.cancel();
  }

  void refresh() {
    initView();
  }

  var name,
      sex,
      age,
      money,
      friends,
      userId = "1",
      vipicon,
      vipmsg,
      headimg,
      vipType,
      poll;

  Future initView() async {
    userId = await Tinker.getuserID();
    if (userId == null) {
      setState(() {
        name = "请登录";
        age = "年龄";
        sex = "性别";
        money = "0";
        friends = "0";
      });
    } else {
      FormData param = FormData.from({
        "userId": userId == null ? "" : userId,
        "type": "0",
        "fromUserId": userId == null ? "" : userId
      });
      FormData param1 = FormData.from({"userId": userId});
      Tinker.post("/api/user/doUserMessage", (data) {
        Tinker.post("/api/user/findAllFriend", (path) {
          setState(() {
            name = data["rows"]["userName"];
            age = data["rows"]["age"];
            sex = data["rows"]["sex"] == "0" ? "男" : "女";
            money = data["rows"]["money"];
            friends = path["size"];
            headimg = data["rows"]["headImg"];
            vipType = data["rows"]["vipType"];
            poll = data["rows"]["poll"];
            if (data["rows"]["vipType"] == "0") {
              vipicon = "image/VIP_blank.png";
              vipmsg = "点击立即成为VIP";
            } else {
              vipicon = "image/vip@2x.png";
              vipmsg = "有效期至" + data["rows"]["vipdaoqitime"];
            }
          });
          print(userId);
        }, params: param1);
      }, params: param);
    }
  }

  /*拍照*/
  Future _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        headimg = image.path;
        print(headimg + "------------");
      });
    }
  }

  /*相册*/
  Future _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        headimg = image.path;
        print(headimg + "------------");
        print(image.path + "------------");
      });
    }
  }

  @override
  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
//    super.build(context);
    // TODO: implement build
    _listen();
    //Ios风格弹窗
    final size = MediaQuery.of(context).size;
    final width = size.width;
    void showMySimpleDialog(BuildContext context) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return new CupertinoAlertDialog(
              title: new Text("您的邀请码"),
              content: new Text(poll),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop("点击了确定");
                  },
                  child: new Text("确认"),
                ),
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop("点击了取消");
                  },
                  child: new Text("取消"),
                ),
              ],
            );
          });
    }

    void showKefu(BuildContext context) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: Align(
                child: new Text("提醒"),
                alignment: Alignment.topLeft,
              ),
              content: Container(
                width: 200,
                height: 50,
                child: new Text("如有问题，请拨打客服电话188557378957"),
                alignment: Alignment.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop("点击了确定");
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: new Text(
                      "确认",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
//                new FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop("点击了取消");
//                  },
//                  child: new Text("取消"),
//                ),
              ],
            );
          });
    }

    //Android风格弹层
    void showMyMaterialDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) {
            return new Container(
              child: AlertDialog(
                title: new Text("提醒"),
                content: new Container(
                  child: Text("如有问题，请拨打客服电话18857378957"),
                  width: 260,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                ),
                actions: <Widget>[
                  new FlatButton(
                    padding: EdgeInsets.only(top: 0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("确认"),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              width: 200,
              height: 100,
            );
          });
    }

    return Material(
      child: userId == ""
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
//      appBar: AppBar(
//        brightness: Brightness.light,
//        title: Text(
//          "我的",
//          style: TextStyle(color: Colors.black, fontSize: 22),
//        ),
//        elevation: 0,
//        backgroundColor: Colors.white,
//      ),
              body: SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new Container(
                        child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            "我的",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          margin: EdgeInsets.fromLTRB(15, 30, 0, 0),
                        ),
                        new Row(
                          children: <Widget>[
                            new Container(
                              child: new Row(
                                children: <Widget>[
                                  GestureDetector(
                                    child: new Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(70),
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: headimg == null
                                                ? Image.asset(
                                                    "image/nologin@2x.png")
                                                : new ClipOval(
                                                    child: ClipOval(
                                                        child: new SizedBox(
                                                      width: 70,
                                                      height: 70,
                                                      child: CachedNetworkImage(
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.fill,
                                                          imageUrl:
                                                              "http://imgs.jiashilan.com/" +
                                                                  "$headimg"),
                                                    )),
                                                  ),
                                            height: 70,
                                            width: 70,
                                          )
                                        ],
                                      ),
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      height: 120,
                                      width: 70,
                                    ),
                                    onTap: () {
                                      if (userId == null) {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) => Login()));
                                      } else {
//                                        showModalBottomSheet(
//                                            context: context,
//                                            builder: (BuildContext context) {
//                                              return SafeArea(
//                                                  child: new Column(
//                                                mainAxisSize: MainAxisSize.min,
//                                                children: <Widget>[
//                                                  new ListTile(
//                                                    leading: AppConfig
//                                                        .Image_picker_icon1,
//                                                    title: new Text(AppConfig
//                                                        .Image_picker_name1),
//                                                    onTap: () async {
//                                                      _takePhoto();
//                                                      Navigator.of(context)
//                                                          .pop();
//                                                    },
//                                                  ),
//                                                  new ListTile(
//                                                    leading: AppConfig
//                                                        .Image_picker_icon2,
//                                                    title: new Text(AppConfig
//                                                        .Image_picker_name2),
//                                                    onTap: () async {
//                                                      _openGallery();
//                                                      Navigator.of(context)
//                                                          .pop();
//                                                    },
//                                                  ),
//                                                ],
//                                              ));
//                                            });
                                      }
                                    },
                                  ),
                                  GestureDetector(
                                    child: new Container(
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            child: new Text(
                                              "$name",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: 25, top: 30),
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              new Container(
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Container(
                                                      child: Image.asset(
                                                        "image/age@2x.png",
                                                        height: 12,
                                                      ),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 5, 0),
                                                    ),
                                                    new Text("$age"),
                                                  ],
                                                ),
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 15, 0),
                                              ),
                                              new Container(
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Container(
                                                      child: sex == "1"
                                                          ? Image.asset(
                                                              "image/female@2x.png",
                                                              height: 12,
                                                            )
                                                          : Image.asset(
                                                              "image/male@2x.png",
                                                              height: 12,
                                                            ),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 5, 0),
                                                    ),
                                                    new Text("$sex"),
                                                  ],
                                                ),
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 15, 0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
                                    ),
                                    onTap: () async {
                                      if (await Tinker.getuserID() == null) {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) => Login()));
                                      }
                                    },
                                  ),
                                ],
                                //                        mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              height: 180,
                            ),
                            Container(
                              child: userId == null
                                  ? null
                                  : new Container(
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                "image/path_8@2x.png"),
                                            fit: BoxFit.contain // 填满
                                            ),
                                      ),
                                      child: new Container(
                                        child: new Column(
                                          children: <Widget>[
                                            new Container(
                                              child: new Image.asset(
                                                "$vipicon",
                                                height: 20,
                                              ),
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 67, 0, 0),
                                            ),
                                            InkWell(
                                              child: new Container(
                                                child: new Text(
                                                  "$vipmsg",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromRGBO(
                                                        165, 165, 177, 1),
                                                  ),
                                                ),
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 15, 0, 10),
                                              ),
                                              onTap: () {
                                                if (vipType == "0") {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              openVip()));
                                                } else
                                                  Tinker.toast("你已经是会员了");
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      width: 150,
                                      height: 180,
                                    ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ],
                    )),
                    new Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      padding: const EdgeInsets.only(top: 25.0),
                      height: 100,
                      decoration: new BoxDecoration(
                        border: new Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor),
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor)),
                      ),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new InkWell(
                            child: new Container(
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: Text("$friends"),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  ),
                                  new Text(
                                    "好友邀请",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(165, 165, 177, 1)),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              if (userId == null) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Login()));
                              } else {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SecondScreen()));
                              }
                            },
                          ),
                          new InkWell(
                            child: new Container(
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: new Text("$money"),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  ),
                                  new Text(
                                    "账户余额",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(165, 165, 177, 1)),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              if (userId == null) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Login()));
                              } else {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => balance()));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: new Column(
                        children: <Widget>[
                          new InkWell(
                            child: new Container(
                              margin: EdgeInsets.only(bottom: 12, top: 20),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "个人资料",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              if (userId == null) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Login()));
                              } else {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => person()));
                              }
                            },
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "我的发布",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              if (userId == null) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Login()));
                              } else {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => release()));
                              }
                            },
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "认证用户列表",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              if (userId == null) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Login()));
                              } else {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => authentation()));
                              }
                            },
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "我的邀请码",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              showMySimpleDialog(context);
                            },
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "下载小黑裙",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => download()));
                            },
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "设置",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Settings()));
                            },
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "联系客服",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  new Image.asset(
                                    "image/shape_copy2@2x.png",
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                            onTap: () async {
                              var result = await showDialog(
                                  context: context, //BuildContext对象
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return new LDialog(
                                        //调用对话框
                                        );
                                  });
                              //                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => openVip()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
