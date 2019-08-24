import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/User.dart';

class chat extends StatefulWidget {
  var id;
  chat(this.id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatSate();
  }
}

class chatSate extends State<chat> {
  Future sendMessage() async {
//    发送消息
    TextMessage txtMessage = new TextMessage();
    txtMessage.content = _control.text;
    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, widget.id, txtMessage);
    setState(() {
      initView();
      _control.text = "";
    });
    print("send message start senderUserId = " + msg.senderUserId);
  }

  List TextMsg;
  List msgs;
  int count;
  var userId;
  User user, targetUser;

  Future initView() async {
    userId = await Tinker.getuserID();
    Tinker.queryUserInfo(userId, (data) {
      setState(() {
        user = User.fromJson(data);
      });
    });
    Tinker.queryUserInfo(widget.id, (data) {
      setState(() {
        targetUser = User.fromJson(data);
      });
    });
    //获取用户信息
    msgs = await RongcloudImPlugin.getHistoryMessage(
        RCConversationType.Private, widget.id, 0, 10);
    count = msgs.length;
    print("get history message");
    TextMsg = msgs.reversed.toList();
//    print("sentTime = " + msgs.length.toString());
//    print(msgs[0]);
//    for (Message m in msgs) {
//      TextMessage a = m.content;
//      print(a.content);
//    }
//    int a = 0;
//    for (var i = (msgs.length - 1); i > (-1); i--) {
//      TextMsg[a] = msgs[i];
//      a++;
//    }
//    for (var i = 0; i < 10; i++) print(TextMsg[i].content.content + "第零调塑胶");
//    print(TextMsg.length);
  }

  @override
  void initState() {
    super.initState();
    initView();
  }

  Widget Lists() {
    return TextMsg == null || targetUser == null || user == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              return TextMsg[index].senderUserId == widget.id
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.black12)),
                          child: ClipOval(
                            child: Image.network(
                              AppConfig.AJAX_IMG_SERVER + targetUser.headImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(targetUser.userName),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                child: Text(TextMsg[index].content.content),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(user.userName),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                child: Text(TextMsg[index].content.content),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.black12)),
                          child: ClipOval(
                            child: Image.network(
                              AppConfig.AJAX_IMG_SERVER + user.headImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
            });
  }

  TextEditingController _control = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "目标用户名",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                height: double.infinity,
                child: Lists(),
              ),
            ),
            Positioned(
                bottom: 0,
                child: SafeArea(
                    child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black45))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          "ChatBox/rec.png",
                          width: 32,
                          height: 32,
                        ),
                      ),
                      Container(
                        width: size.width * 0.65,
                        height: 30,
                        margin: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black45)),
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 16),
                          controller: _control,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 5),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Image.asset(
                          "ChatBox/face1.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      InkWell(
                        child: Container(
                            height: 35,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: Text(
                              "发送",
                              style: TextStyle(color: Colors.white),
                            )),
                        onTap: () {
                          sendMessage();
                        },
                      ),
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
