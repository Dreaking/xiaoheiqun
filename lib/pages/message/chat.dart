import 'dart:async';
import 'dart:io';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/chatService/meadia_util.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/rongyunListen.dart';
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
  @override
  void initState() {
    super.initState();
    initView();
    setaddListener();
  }

  Future sendMessage() async {
//    发送消息
    TextMessage txtMessage = new TextMessage();
    txtMessage.content = _control.text;
    if (_control.text != "") {
      Message msg = await RongcloudImPlugin.sendMessage(
          RCConversationType.Private, widget.id, txtMessage);
      setState(() {
        initView();
        _control.text = "";
      });
    }
  }

  var upScor = 0, startRecoder = 0;

  List TextMsg;
  List msgs;
  int count;
  var userId, voice = 0;
  User user = null, targetUser = null;
  int bottomUp = 0;
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
        RCConversationType.Private, widget.id, 0, 20);
    count = msgs.length;
    print("get history message");
    VoicImage = new List(count);
    initVoicImage();
//    for (Message m in msgs) {
//      VoiceMessage a = m.content;
//      print(a.remoteUrl);
//      print(a.localPath);
//      print(a.duration);
//      print(m.objectName);
//      print("sentTime = " + m.content.toString());
//    }
    //倒序
    TextMsg = msgs.reversed.toList();
  }

  //设置融云监听
  void setaddListener() {
    bus.addListener(EventKeys.ReceiveMessage, (data) {
      setState(() {
        initView();
      });
    });
  }

  /*拍照*/
  Future _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    String path;
    if (TargetPlatform.android == defaultTargetPlatform) {
      path = "file://" + image.path;
    } else {
      path = image.path;
    }
    if (image != null) {
      ImageMessage imgMsg = ImageMessage.obtain("file://" + path);
      Message msg = await RongcloudImPlugin.sendMessage(
          RCConversationType.Private, widget.id, imgMsg);
    }
  }

  Future pick_Image() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    String path;
    if (TargetPlatform.android == defaultTargetPlatform) {
      path = "file://" + image.path;
    } else {
      path = image.path;
    }
    if (image != null) {
      ImageMessage imgMsg = ImageMessage.obtain(path);
      Message msg = await RongcloudImPlugin.sendMessage(
          RCConversationType.Private, widget.id, imgMsg);
      setState(() {
        initView();
      });
    }
  }

  ScrollController _controller;
  List VoicImage = new List();
  void initVoicImage() {
    for (var i = 0; i < count; i++) {
      VoicImage[i] = ("ChatBox/stop.png");
    }
  }

  FlutterSound flutterSound = new FlutterSound();
  int millseconds;
  var path;
  Future statrVcMessage() async {
    String path = await flutterSound.startRecorder(null);
    print('startRecorder: $path');
    print("111111111111111111");
    this.path = path;
    var _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
      DateTime date =
          new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      print(e.currentPosition.toString() + "aaaaaaaaaaa");
      millseconds = e.currentPosition.toInt();
    });
  }

  Future stopVcMessage() async {
    String result = await flutterSound.stopRecorder();
    print('stopRecorder: $result');
  }

  Future SendVcMessage() async {
    stopVcMessage();
    print(millseconds);
    willSendVoice("file://" + path, millseconds);
    print("dddddddd");
  }

  void willSendVoice(String path, int duration) async {
    print("只你高兴");
    VoiceMessage msg = VoiceMessage.obtain(path, duration);
    Message message = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, widget.id, msg);
    setState(() {
      initView();
    });
  }

  TextEditingController _control = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return user == null || targetUser == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  targetUser.userName,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: Container(
                child: Stack(
                  children: <Widget>[
                    SafeArea(
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  child: GestureDetector(
                                    child: ListView.builder(
                                      key: UniqueKey(),
                                      shrinkWrap: true,

                                      //因为消息超过一屏，ListView 很难滚动到最底部，所以要翻转显示，同时数据源也要逆序
                                      reverse: true,
                                      controller: _controller,
                                      itemCount: msgs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (msgs.length != null &&
                                            msgs.length > 0) {
                                          return msgs[index].senderUserId ==
                                                  widget.id
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12)),
                                                      child: ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl: AppConfig
                                                                .AJAX_IMG_SERVER +
                                                            targetUser.headImg,
                                                        placeholder:
                                                            (context, url) =>
                                                                new Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new SizedBox(
                                                              width: 10,
                                                              height: 10,
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          ],
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            new Icon(
                                                                Icons.error),
                                                      )
//                                                        Image.network(
//                                                          AppConfig
//                                                                  .AJAX_IMG_SERVER +
//                                                              targetUser
//                                                                  .headImg,
//                                                          fit: BoxFit.cover,
//                                                        ),
                                                          ),
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(targetUser
                                                            .userName),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                          ),
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        7),
                                                            child: msgs[index]
                                                                        .objectName ==
                                                                    "RC:ImgMsg"
                                                                ? Image.network(
                                                                    msgs[index]
                                                                        .content
                                                                        .imageUri,
                                                                    width: 50,
                                                                    height: 50,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : msgs[index]
                                                                            .objectName ==
                                                                        "RC:HQVCMsg"
                                                                    ? Row(
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Image.asset(
                                                                              VoicImage[index],
                                                                              width: 20,
                                                                              height: 20,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                VoicImage[index] = "ChatBox/playing.gif";
                                                                              });
                                                                              Timer timer = new Timer(new Duration(seconds: msgs[index].content.duration / 1000), () {
                                                                                // 只在倒计时结束时回调
                                                                                setState(() {
                                                                                  VoicImage[index] = "ChatBox/stop.png";
                                                                                });
                                                                              });
                                                                              MediaUtil.instance.startPlayAudio(msgs[index].content.localPath);
                                                                            },
                                                                          ),
                                                                          Text(
                                                                              "${(msgs[index].content.duration / 1000).toString()}''")
                                                                        ],
                                                                      )
                                                                    : Text(msgs[
                                                                            index]
                                                                        .content
                                                                        .content),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Text(user.userName),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        7),
                                                            child: msgs[index]
                                                                        .objectName ==
                                                                    "RC:ImgMsg"
                                                                ? CachedNetworkImage(
                                                                    imageUrl: msgs[
                                                                            index]
                                                                        .content
                                                                        .imageUri,
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            new Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        new SizedBox(
                                                                          width:
                                                                              10,
                                                                          height:
                                                                              10,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        new Icon(
                                                                            Icons.error),
                                                                  )
//                                                            Image.network(
//                                                                    msgs[index]
//                                                                        .content
//                                                                        .imageUri,
//                                                                    width: 50,
//                                                                    height: 50,
//                                                                    fit: BoxFit
//                                                                        .cover,
//                                                                  )
                                                                : msgs[index]
                                                                            .objectName ==
                                                                        "RC:HQVCMsg"
                                                                    ? Row(
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Image.asset(
                                                                              VoicImage[index],
                                                                              width: 20,
                                                                              height: 20,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                VoicImage[index] = "ChatBox/playing.gif";
                                                                              });
                                                                              Timer timer = new Timer(new Duration(milliseconds: msgs[index].content.duration), () {
                                                                                // 只在倒计时结束时回调
                                                                                setState(() {
                                                                                  VoicImage[index] = "ChatBox/stop.png";
                                                                                });
                                                                              });
                                                                              MediaUtil.instance.startPlayAudio(msgs[index].content.localPath);
                                                                            },
                                                                          ),
                                                                          Text(
                                                                              "${(msgs[index].content.duration / 1000).toString()}''")
                                                                        ],
                                                                      )
                                                                    : Text(msgs[
                                                                            index]
                                                                        .content
                                                                        .content),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                          left: 8, right: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12)),
                                                      child: ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: AppConfig
                                                                  .AJAX_IMG_SERVER +
                                                              user.headImg,
                                                          placeholder:
                                                              (context, url) =>
                                                                  new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              new SizedBox(
                                                                width: 10,
                                                                height: 10,
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              )
                                                            ],
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                        } else {
                                          return Container(
                                            height: 1,
                                            width: 1,
                                          );
                                          ;
                                        }
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        bottomUp = 0;
                                      });

                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.black45))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  child: ClipOval(
                                    child: Image.asset(
                                      "ChatBox/rec.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  onTap: () {
                                    if (voice == 0) {
                                      setState(() {
                                        voice = 1;
                                      });
                                    } else {
                                      setState(() {
                                        voice = 0;
                                      });
                                    }
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: size.width * 0.65,
                                    height: 30,
                                    margin: EdgeInsets.only(top: 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border:
                                            Border.all(color: Colors.black45)),
                                    child: voice == 1
                                        ? Container(
                                            width: size.width * 0.65,
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: Text("按住说话"),
                                          )
                                        : TextField(
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(fontSize: 16),
                                            controller: _control,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.only(top: 5),
                                            ),
                                          ),
                                  ),
                                  onLongPress: () {
                                    print("开始录制");
                                    setState(() {
                                      startRecoder = 1;
                                      statrVcMessage();
                                    });
                                  },
//                                  onPanStart: (da) {
//                                    print("长按上滑");
//                                    //加入上滑标记
//                                    stopVcMessage();
//                                    setState(() {
//                                      upScor = 1;
//                                      startRecoder = 0;
//                                    });
//                                  },

                                  onLongPressUp: () {
                                    //识别是否进行过上滑按钮
                                    if (upScor == 0) {
                                      print("长按结束");
                                      setState(() {
                                        startRecoder = 0;
                                      });
                                      SendVcMessage();
                                    }
                                    upScor = 0;
                                  },
                                ),
//                                ClipOval(
//                                  child: Image.asset(
//                                    "ChatBox/face1.png",
//                                    width: 30,
//                                    height: 30,
//                                  ),
//                                ),
                                InkWell(
                                  child: ClipOval(
                                    child: Image.asset(
                                      "ChatBox/add1.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  onTap: () {
                                    if (bottomUp == 0) {
                                      setState(() {
                                        bottomUp = 1;
                                      });
                                    } else {
                                      setState(() {
                                        bottomUp = 0;
                                      });
                                    }
                                  },
                                ),
                                InkWell(
                                  child: Container(
                                      height: 35,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                          ),
                          Container(
                            height: bottomUp == 0 ? 0 : 100,
                            child: bottomUp == 0
                                ? null
                                : Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: <Widget>[
                                            InkWell(
                                              child: Image.asset(
                                                "ChatBox/img1.png",
                                                width: 70,
                                                height: 70,
                                              ),
                                              onTap: () {
                                                pick_Image();
                                              },
                                            ),
                                            Text("相册照片")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            InkWell(
                                              child: Image.asset(
                                                "ChatBox/cam1.png",
                                                width: 70,
                                                height: 70,
                                              ),
                                              onTap: () {
                                                _takePhoto();
                                              },
                                            ),
                                            Text("相机拍照")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      child: startRecoder == 1
                          ? Image.asset(
                              "image/voiceTip.gif",
                              width: size.width * 0.35,
                              height: size.width * 0.35,
                            )
                          : Container(),
                      bottom: (size.height - size.width * 0.35) / 2,
                      left: (size.width - size.width * 0.35) / 2,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bus.removeListener(EventKeys.ReceiveMessage);
    eventBus.fire(JoinChatEvent(1));
  }
}
