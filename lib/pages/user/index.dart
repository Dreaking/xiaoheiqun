import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/user/person_data.dart';
import 'package:xiaoheiqun/pages/user/release.dart';
import 'package:xiaoheiqun/pages/user/settings.dart';

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

class UserIndexState extends State<UserIndex> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Ios风格弹窗
    void showMySimpleDialog(BuildContext context) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return new CupertinoAlertDialog(
              title: new Text("您的邀请码"),
              content: new Text("O177OPB4"),
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
            return new CupertinoAlertDialog(
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tinker.getThemeData(),
      home: Scaffold(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.fromLTRB(15, 30, 0, 0),
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              child: new ClipOval(
                                child: Image.asset(
                                  "image/nologin@2x.png",
                                  height: 70,
                                ),
                              ),
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              height: 120,
                              width: 70,
                            ),
                            new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "用户-873",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
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
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                            ),
                                            new Text("20"),
                                          ],
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 15, 0),
                                      ),
                                      new Container(
                                        child: new Row(
                                          children: <Widget>[
                                            new Container(
                                              child: Image.asset(
                                                "image/male@2x.png",
                                                height: 12,
                                              ),
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                            ),
                                            new Text("男"),
                                          ],
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 15, 0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
                            ),
                          ],
                          //                        mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        height: 120,
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: new AssetImage("image/path_8@2x.png"),
                              fit: BoxFit.contain // 填满
                              ),
                        ),
                        child: new Container(
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                child: new Image.asset(
                                  "image/vip@2x.png",
                                  height: 20,
                                ),
                                margin: EdgeInsets.fromLTRB(0, 67, 0, 0),
                              ),
                              new Container(
                                child: new Text(
                                  "有效期至2020-02-04",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(165, 165, 177, 1),
                                  ),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                              ),
                            ],
                          ),
                        ),
                        width: 150,
                        height: 180,
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
                      top: BorderSide(color: Theme.of(context).dividerColor),
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor)),
                ),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: new Text("0"),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),
                            new Text(
                              "好友邀请",
                              style: TextStyle(
                                  color: Color.fromRGBO(165, 165, 177, 1)),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SecondScreen()));
                      },
                    ),
                    new GestureDetector(
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: new Text("0"),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),
                            new Text(
                              "账户余额",
                              style: TextStyle(
                                  color: Color.fromRGBO(165, 165, 177, 1)),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => balance()));
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
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => person()));
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
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => release()));
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
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => authentation()));
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
                      onTap: () {
                        showKefu(context);
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
