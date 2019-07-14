import 'package:flutter/material.dart';

class sys_msg_detail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sys_msg_detailState();
  }
}

class sys_msg_detailState extends State<sys_msg_detail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "系统消息",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "小黑裙上线",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "2019-03-04",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  child: Text(
                    "       小黑裙现已正式上线，您已开通VIP权限，现可以发布动态和日常聊天，现邀请好友成为会员可获得返利！",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
