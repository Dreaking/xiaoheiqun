import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/rongyunListen.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/User.dart';
import 'package:intl/intl.dart' show DateFormat;

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

    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, widget.id, txtMessage);
    setState(() {
      initView();
      _control.text = "";
    });
    print("send message start senderUserId = " + msg.senderUserId);
  }

  String vcLocal;
  void startRecorder() async {
    try {
      String path = await flutterSound.startRecorder(null);
      print('startRecorder: $path');
      setState(() {
        vcLocal = path;
      });
      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      });
      _dbPeakSubscription =
          flutterSound.onRecorderDbPeakChanged.listen((value) {
        print("got update -> $value");
        setState(() {
          this._dbLevel = value;
        });
      });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async {
    try {
      String result = await flutterSound.stopRecorder();
      print('stopRecorder: $result');

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  //发送语音消息
  Future sendVSMessage() async {
    VoiceMessage vc = new VoiceMessage();
    print(vcLocal);
    print("ceshi");
    vc.localPath = vcLocal;
    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, widget.id, vc);
    setState(() {
      initView();
    });
  }

  FlutterSound flutterSound = new FlutterSound();
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';
  double _dbLevel;
  bool _isRecording = false;
  var upScor = 0, startRecoder = 0;

  double slider_current_position = 0.0;
  double max_duration = 1.0;
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

  ScrollController _controller;

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
                                                      margin: EdgeInsets.only(
                                                          left: 8, right: 8),
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12)),
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          AppConfig
                                                                  .AJAX_IMG_SERVER +
                                                              targetUser
                                                                  .headImg,
                                                          fit: BoxFit.cover,
                                                        ),
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
                                                            child: Text(
                                                                msgs[index]
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
                                                            child: Text(
                                                                msgs[index]
                                                                    .content
                                                                    .content),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
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
                                                        child: Image.network(
                                                          AppConfig
                                                                  .AJAX_IMG_SERVER +
                                                              user.headImg,
                                                          fit: BoxFit.cover,
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
                                        voice == 0;
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
                                      this.startRecorder();
                                    });
                                  },
//                            onLongPressMoveUpdate: (da) {
//                              print("长按上滑");
//                              //加入上滑标记
//                              setState(() {
//                                upScor = 1;
//                                this.stopRecorder();
//                              });
//                            },
                                  onLongPressUp: () {
                                    //识别是否进行过上滑按钮
                                    if (upScor == 0) this.stopRecorder();
                                    print("长按结束");
                                    setState(() {
                                      startRecoder = 0;
                                    });
                                    sendVSMessage();
                                  },
                                ),
                                ClipOval(
                                  child: Image.asset(
                                    "ChatBox/face1.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
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
                                            Image.asset(
                                              "ChatBox/img1.png",
                                              width: 70,
                                              height: 70,
                                            ),
                                            Text("相册照片")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset(
                                              "ChatBox/cam1.png",
                                              width: 70,
                                              height: 70,
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
