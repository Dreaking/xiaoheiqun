import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/common/wxchart.dart';
import 'package:tobias/tobias.dart' as tobias;
import 'package:xiaoheiqun/data/Vip_Price.dart';

class pay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return payState();
  }
}

class payState extends State<pay> {
  @override
  var _pay = "weipay";
  String month = '';
  String type = "";
  String money = "";
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return Material(
      child: movies == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "在线支付",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                leading: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(children: <Widget>[
                        //头标提示
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Color.fromRGBO(249, 244, 255, 1)),
                                  bottom: BorderSide(
                                      color:
                                          Color.fromRGBO(249, 244, 255, 1)))),
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "请选择开通会员时长",
                              style: TextStyle(
                                  color: Color.fromRGBO(129, 129, 129, 1)),
                            ),
                          ),
                        ),
                        Container(
                          height: 60 * movies.length.toDouble(),
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromRGBO(
                                                  249, 244, 255, 1)))),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Radio<String>(
                                          value: '${movies[index].month}',
                                          activeColor:
                                              Color.fromRGBO(218, 4, 32, 1),
                                          groupValue: month,
                                          onChanged: (value) {
                                            setState(() {
                                              month = value;
                                            });
                                            money = movies[index].money;
                                            type = movies[index].type;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 60),
                                        child: Text(
                                          movies[index].type == 1
                                              ? "${movies[index].month}个月"
                                              : "${movies[index].month}天体验",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Text(
                                        "￥${movies[index].money}",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(218, 4, 32, 1),
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Color.fromRGBO(249, 244, 255, 1)))),
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "请在",
                                  style: TextStyle(
                                      color: Color.fromRGBO(129, 129, 129, 1)),
                                ),
                                Text(
                                  constructTime(seconds),
                                  style: TextStyle(
                                      color: Color.fromRGBO(218, 4, 32, 1)),
                                ),
                                Text(
                                  "时间内完成支付，到期后自动取消",
                                  style: TextStyle(
                                      color: Color.fromRGBO(129, 129, 129, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //微信支付
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Color.fromRGBO(249, 244, 255, 1)))),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Radio<String>(
                                  value: "weipay",
                                  groupValue: _pay,
                                  activeColor: Color.fromRGBO(218, 4, 32, 1),
                                  onChanged: (value) {
                                    setState(() {
                                      _pay = value;
                                    });
                                  },
                                ),
                                Container(
                                  child: Image.asset(
                                    "image/alpay@2x.png",
//                              width: 100,
                                    fit: BoxFit.cover,
                                    height: 50,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "支付宝支付",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  margin: EdgeInsets.only(left: 40),
                                )
                              ],
                            ),
                          ),
                        ),
                        //协议
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    "$xieyi",
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (xieyi_sel == 0) {
                                      xieyi = "image/sel_@2x_294.png";
                                      xieyi_sel = 1;
                                    } else {
                                      xieyi_sel = 0;
                                      xieyi = "image/sel_@2x_290.png";
                                    }
                                  });
                                },
                              ),
                              Text("我同意"),
                              Text(
                                "《会员协议》",
                                style: TextStyle(
                                    color: Color.fromRGBO(124, 187, 230, 1)),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                    Positioned(
                      child: SafeArea(
                          child: GestureDetector(
                        child: Container(
                          height: 45,
                          width: width,
                          alignment: Alignment.center,
                          color: Color.fromRGBO(254, 0, 8, 1),
                          child: Text(
                            "立即支付",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
//                    WxPay.SHare();
//                    WxPay.register();
//                    WxPay.getPrepayid();
                          if (xieyi_sel == 0) {
                            Tinker.toast("请先同意相关协议");
                          } else
                            alipay();
                        },
                      )),
                      bottom: 0,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  var userId;

  Future alipay() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": await Tinker.getuserID()});
    final res = await http.post("http://pay.fuful.com/alipay/payInfo");
    var data = json.decode(res.body);
    var payResult = await tobias.pay(data["rows"]["data"]);
    print(payResult);
    FormData open_Vip = FormData.from(
        {"userId": userId, "month": month, "money": money, "type": type});
    if (payResult["resultStatus"] == "9000") {
      Tinker.post("/api/user/openVip", (data) {
        eventBus.fire(new UserLoggedInEvent("10"));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TinkerScaffold()),
            (route) => route == null);
      }, params: open_Vip);
    } else {
      Tinker.toast(payResult["memo"]);
    }
    tobias.isAliPayInstalled().then((data) {
      print("installed $data");
    });
  }

  var xieyi = "image/sel_@2x_290.png";
  var xieyi_sel = 0;
//定时器的使用------------
  Timer _timer;
  int seconds;
  //时间格式化，根据总秒数转换为对应的 hh:mm:ss 格式
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) +
        ":" +
        formatTime(minute) +
        ":" +
        formatTime(second);
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  List movies;
  Future initView() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId});
    Tinker.post("/api/vip/findVipPrice", (data) {
      print(data);
      List top = data["rows"];
      movies = top.map((json) => Price.fromJson(json)).toList();
      setState(() {
        month = movies[0].month;
        money = movies[0].money;
        type = movies[0].type.toString();
      });
      print("sss");
    }, params: param);
  }

  @override
  void initState() {
    super.initState();
    initView();
    //获取当期时间
    var now = DateTime.now();
    //获取 2 分钟的时间间隔
    var twoHours = now.add(Duration(days: 1)).difference(now);
    //获取总秒数，2 分钟为 120 秒
    seconds = twoHours.inSeconds;
    startTimer();
    fluwx.register(appId: AppConfig.WX_PAY_ID);
  }

  void startTimer() {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
        seconds--;
      });
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}
