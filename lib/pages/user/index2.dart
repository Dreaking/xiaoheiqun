import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xiaoheiqun/common/KefuDiag.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/user/authentation_user.dart';
import 'package:xiaoheiqun/pages/user/balance.dart';
import 'package:xiaoheiqun/pages/user/download.dart';
import 'package:xiaoheiqun/pages/user/friendInvitation.dart';
import 'package:xiaoheiqun/pages/user/index2Left.dart';
import 'package:xiaoheiqun/pages/user/pay.dart';
import 'package:xiaoheiqun/pages/user/person_data.dart';
import 'package:xiaoheiqun/pages/user/release.dart';
import 'package:xiaoheiqun/pages/user/settings.dart';
import 'package:xiaoheiqun/login.dart';

class UserIndex2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserIndexState2();
  }
}

class UserIndexState2 extends State<UserIndex2>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
//监听Bus events
  StreamSubscription _control;

  var _tabControl;
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
    // TODO: implement initState
    super.initState();
    initView();
    _tabControl = TabController(length: 2, vsync: this);
  }

  void refresh() {
    initView();
  }

  var name = "",
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

    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text(name),
              new Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: new Column(
                  children: <Widget>[
                    new InkWell(
                      child: new Container(
                        margin: EdgeInsets.only(bottom: 12, top: 20),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              "下载小黄鱼",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      appBar: name == null
          ? null
          : AppBar(
              backgroundColor: Color.fromRGBO(250, 250, 250, 1),
              elevation: 0,
              title: Text(
                name != null ? name : "",
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              actions: <Widget>[],
            ),
      body: userId == "" || name == null
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : new Column(
              children: <Widget>[
                new Container(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: new Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: headimg == null
                                      ? Image.asset("image/nologin@2x.png")
                                      : new ClipOval(
                                          child: ClipOval(
                                          child: CachedNetworkImage(
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.fill,
                                              imageUrl:
                                                  "http://imgs.jiashilan.com/" +
                                                      "$headimg"),
                                        )),
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  height: 80,
                                  width: 80,
                                ),
                                onTap: () {
                                  if (userId != null) {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => person()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => Login()));
                                  }
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 0),
                                child: Text(name),
                              )
                            ],
                            //                        mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          width: width * 0.25,
                        ),
                        Container(
                          width: size.width * 0.75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 1)),
                              GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      friends.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Text("好友邀请"),
                                    )
                                  ],
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
                                            builder: (context) =>
                                                SecondScreen()));
                                  }
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(money.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        margin: EdgeInsets.only(top: 2),
                                        child: Text("账户余额"),
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
                                            builder: (context) => balance()));
                                  }
                                },
                              ),
                              Column(
                                children: <Widget>[
                                  Text(age.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Text("年龄"),
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(right: 0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )),
                Padding(padding: EdgeInsets.only(top: 30)),
                //中部邀请余额信息
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: new Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Text(
                      "编辑主页",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (userId == null) {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Login()));
                    } else {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => person()));
                    }
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black12))),
                    height: 50,
                    child: TabBar(
                        indicatorWeight: 1,
                        indicatorColor: Colors.black45,
                        controller: _tabControl,
                        tabs: <Widget>[
                          Icon(
                            Icons.tab,
                            color: Colors.black,
                          ),
                          Icon(
                            Icons.event,
                            color: Colors.black,
                          )
                        ])),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[index2Left(), index2Left()],
                    controller: _tabControl,
                  ),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _control.cancel();
  }
}
