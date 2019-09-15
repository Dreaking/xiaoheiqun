import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provide/provide.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/rongyunListen.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/common/app_launch.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoheiqun/microMall/provide/currentIndex.dart';

void main() {
  var providers = new Providers();
  var currentIndex = new CurrentIndexProvide();
  providers..provide(Provider<CurrentIndexProvide>.value(currentIndex));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
//  static const platform = const MethodChannel('com.fuman.flutter/u_push');
//
//  Future<Null> _getBatteryLevel() async {
//    final String result = await platform.invokeMethod('init');
////    Tinker.toast(result);
//  }
  final JPush jpush = new JPush();
  String debugLable = 'Unknown';

  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
      print("tokenId:");
      print(rid);
    });

    jpush.setup(
      appKey: "7861397af19cbdeaef2afa47",
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          setState(() {
            debugLable = "flutter onReceiveNotification: $message";
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLable = "flutter onReceiveMessage: $message";
          });
        },
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initRongyun();
    RongyunListener();
  }

  Future initRongyun() async {
    Dio dio = new Dio();
    FormData param;
    RongcloudImPlugin.init("pvxdm17jpo89r");

    var userId = await Tinker.getuserID();
    var chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';
    var maxPos = chars.length - 1;
    int len = 32;
    var pwd = '';
    var random = Random();

    var timeStamp =
        int.parse((new DateTime.now().millisecondsSinceEpoch).toString());

    for (var i = 0; i < len; i++) {
      pwd += chars[random.nextInt(maxPos)];
    }
    var data = "KoCZCOxWlv$pwd$timeStamp";
    var bytes = utf8.encode(data); // data being hashed
    var digest = sha1.convert(bytes);
    if (userId != null) {
      print(userId);
      Tinker.queryUserInfo(userId, (data) async {
        print("开始");
        print(data["userName"]);
        param = FormData.from({
          "userId": userId.toString(),
          "name": data["userName"].toString(),
          "portraitUri": AppConfig.AJAX_IMG_SERVER + data["headImg"].toString()
        });
        print("getToken");

        final res = await http.post(
            "http://api-cn.ronghub.com/user/getToken.json",
            body: param,
            headers: {
              "RC-App-Key": "pvxdm17jpo89r",
              "Nonce": pwd,
              "Timestamp": timeStamp.toString(),
              "Signature": digest.toString()
            });
        print('concenct');
        print(res.body);
        int rc =
            await RongcloudImPlugin.connect(json.decode(res.body)["token"]);
        print(rc);
        print('connect result');
      });
    }
  }

  int JoinChat = 1; //未进入chat界面
  Future RongyunListener() async {
    RongcloudImPlugin.onMessageReceived = (Message msg, int left) {
      print("receive message messsageId:" +
          msg.messageId.toString() +
          " left:" +
          left.toString());
      bus.commit(EventKeys.ReceiveMessage, msg);

      print(JoinChat);
      print("判断是否进入chat");
      if (JoinChat == 1) {
        tuisong(msg);
      }
    };
  }

  //监听Bus events
  void _listen() {
    eventBus.on<JoinChatEvent>().listen((event) {
      setState(() {
        JoinChat = event.index;
        print(JoinChat);
        print("数组");
      });
    });
  }

  void tuisong(push) {
    var fireDate = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 3000);
    Tinker.queryUserInfo(push.targetId, (data) {
      var localNotification = LocalNotification(
          id: 234,
          title: data["userName"],
          buildId: 1,
          content: push.content.content.toString(),
          fireTime: fireDate,
          subtitle: 'notification subtitle', // 该参数只有在 iOS 有效
          badge: 5, // 该参数只有在 iOS 有效
          extra: {"fa": "0"} // 设置 extras ，extras 需要是 Map<String, String>
          );
      jpush.sendLocalNotification(localNotification).then((res) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return OKToast(
        child: MaterialApp(
      title: AppConfig.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: Tinker.getThemeData(),
      home: TinkerLaunch(),
    ));
  }
}
