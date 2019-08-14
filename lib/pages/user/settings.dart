import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/pages/user/feedback.dart';

import 'about.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsState();
  }
}

Future launchGooglePlay() async {
  String url = "https://www.pgyer.com/VrkO";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SettingsState extends State<Settings> {
  TextStyle dialogButtonTextStyle;
  var userId;
  Future getData() async {
    userId = await Tinker.getuserID();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showNewVersionAppDialog() async {
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Row(
                children: <Widget>[
                  new Image.asset("images/ic_launcher_icon.png",
                      height: 35.0, width: 35.0),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
                      child: new Text("项目名称", style: dialogButtonTextStyle))
                ],
              ),
              content: new Text(
                '版本更新',
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('以后', style: dialogButtonTextStyle),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('下载', style: dialogButtonTextStyle),
                  onPressed: () {
//                  launch("https://play.google.com/store/apps/details?id=项目包名");
                    launchGooglePlay(); //到Google Play官网去下载APK
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            title: Text(
              "设置",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
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
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "清除缓存",
                            style: TextStyle(fontSize: 15),
                          ),
                          Image.asset(
                            "image/shape_copy2@2x.png",
                            height: 15,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Tinker.clearCache();
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "检查更新",
                            style: TextStyle(fontSize: 15),
                          ),
                          Image.asset(
                            "image/shape_copy2@2x.png",
                            height: 15,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _showNewVersionAppDialog();
                    },
                  ),
                  //关于小黑裙
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "关于小黑裙",
                            style: TextStyle(fontSize: 15),
                          ),
                          Image.asset(
                            "image/shape_copy2@2x.png",
                            height: 15,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => about()));
                    },
                  ),
                  //反馈
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "我要反馈",
                            style: TextStyle(fontSize: 15),
                          ),
                          Image.asset(
                            "image/shape_copy2@2x.png",
                            height: 15,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      if (userId == null) {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => Login()));
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => feedback()));
                      }
                    },
                  ),
                ],
              ),
            ),
            //退出登录
            Container(
              child: userId == ""
                  ? Container()
                  : InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                              color: Color.fromRGBO(238, 238, 238, 1)),
                          bottom: BorderSide(
                              color: Color.fromRGBO(238, 238, 238, 1)),
                        )),
                        child: Text(
                          "退出登录",
                          style: TextStyle(
                              color: Color.fromRGBO(234, 6, 59, 1),
                              fontSize: 17),
                        ),
                      ),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove("user1"); //删除指定键
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => TinkerScaffold()),
                          (route) => route == null,
                        );
                      },
                    ),
            )
          ],
        ));
  }
}
