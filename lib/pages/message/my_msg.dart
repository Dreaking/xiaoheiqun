import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/rongyunListen.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/User.dart';
import 'package:xiaoheiqun/pages/message/chat.dart';

class my_msg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return my_msgState();
  }
}

class my_msgState extends State<my_msg> {
  int count;
  int n = 0, a = 0;

  List conversationList = [], users;

  Future initView() async {
    //获取用户组数据
    RongcloudImPlugin.init("pvxdm17jpo89r");
    List cons = await RongcloudImPlugin.getConversationList(
        [RCConversationType.Private]);
    conversationList = cons;
    users = new List(1);
    for (Conversation con in conversationList) {
      MessageContent a = con.latestMessageContent;
      print(a);
      print("asdsd");
      print(con.unreadMessageCount);
      users[n] = (con.targetId);
    }

    getUsers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
    setaddListener();
  }

  var testList = [];
  void getUsers() {
    for (var i = 0; i < users.length; i++) {
      Tinker.queryUserInfo(users[i], (data) async {
        testList.add(User.fromJson(data));
        setState(() {
          a = 1;
        });
      });
    }
  }

  //设置融云监听
  void setaddListener() {
    bus.addListener(EventKeys.ReceiveMessage, (data) {
      setState(() {
        initView();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return conversationList == []
        ? Center(
            child: Text("暂无数据"),
          )
        : ListView.builder(
            itemCount: conversationList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(40)),
                      child: ClipOval(
                        child: Image.network(
                          AppConfig.AJAX_IMG_SERVER + testList[index].headImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.7,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(testList[index].userName),
                              Container(
                                child: conversationList[index].objectName ==
                                        "RC:ImgMsg"
                                    ? Text(
                                        "[图片]",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : conversationList[index].objectName ==
                                            "RC:HQVCMsg"
                                        ? Text(
                                            "[语音]",
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        : Text(conversationList[index]
                                            .latestMessageContent
                                            .content),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(DateTime.fromMillisecondsSinceEpoch(
                                          conversationList[index].sentTime)
                                      .toString()
                                      .split(" ")[1]
                                      .split(":")[0] +
                                  ":" +
                                  DateTime.fromMillisecondsSinceEpoch(
                                          conversationList[index].sentTime)
                                      .toString()
                                      .split(" ")[1]
                                      .split(":")[1]),
                              Container(
                                child: conversationList[index]
                                            .unreadMessageCount ==
                                        0
                                    ? null
                                    : Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border:
                                                Border.all(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        width: 20,
                                        height: 20,
                                        child: Text(
                                          conversationList[index]
                                              .unreadMessageCount
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  eventBus.fire(JoinChatEvent(0));
                  RongcloudImPlugin.clearMessagesUnreadStatus(
                      RCConversationType.Private,
                      conversationList[index].targetId);
                  initView();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              chat(conversationList[index].targetId)));
                },
              );
            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bus.removeListener(EventKeys.ReceiveMessage);
  }
}
