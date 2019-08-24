import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/User.dart';
import 'package:xiaoheiqun/pages/message/chat.dart';

class my_msg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return my_msgState();
  }
}

class my_msgState extends State<my_msg> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  List conversationList, users;
  int count;
  int n = 0, a = 0;

  Future initView() async {
    //获取用户组数据
    conversationList = await RongcloudImPlugin.getConversationList([
      RCConversationType.Private,
      RCConversationType.Group,
      RCConversationType.System
    ]);
    print(conversationList.length);
    setState(() {
      count = conversationList.length;
    });
    users = new List(count);
    for (Conversation con in conversationList) {
      print("1");
      TextMessage a = con.latestMessageContent;
      print(a.content);
      users[n] = (con.targetId);
      print(con.senderUserId);
      print(con.targetId);
      Tinker.queryUserInfo(con.targetId, (data) {});
      print(con.originContentMap);
    }
    print(users[0]);
    getUsers();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return conversationList == null || a == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: count,
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
                            children: <Widget>[
                              Text(testList[index].userName),
                              Text(conversationList[index]
                                  .latestMessageContent
                                  .content)
                            ],
                          ),
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
                                  .split(":")[1])
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              chat(conversationList[index].targetId)));
                },
              );
            });
  }
}
