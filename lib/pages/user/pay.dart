import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/common/wxchart.dart';
import 'package:tobias/tobias.dart' as tobias;

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
  String _newValue = '1';
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return SafeArea(
        child: Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "在线支付",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
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
                                color: Color.fromRGBO(249, 244, 255, 1)))),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "请选择开通会员时长",
                        style:
                            TextStyle(color: Color.fromRGBO(129, 129, 129, 1)),
                      ),
                    ),
                  ),
                  //充值时间的选择
                  Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(249, 244, 255, 1)))),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Radio<String>(
                                value: '1',
                                activeColor: Color.fromRGBO(218, 4, 32, 1),
                                groupValue: _newValue,
                                onChanged: (value) {
                                  setState(() {
                                    _newValue = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              margin: EdgeInsets.only(left: 10, right: 60),
                              child: Text(
                                "1个月",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "￥98.8",
                              style: TextStyle(
                                  color: Color.fromRGBO(218, 4, 32, 1),
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(249, 244, 255, 1)))),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Radio<String>(
                                value: '3',
                                activeColor: Color.fromRGBO(218, 4, 32, 1),
                                groupValue: _newValue,
                                onChanged: (value) {
                                  setState(() {
                                    _newValue = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              margin: EdgeInsets.only(left: 10, right: 60),
                              child: Text(
                                "3个月",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "￥188",
                              style: TextStyle(
                                  color: Color.fromRGBO(218, 4, 32, 1),
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(249, 244, 255, 1)))),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Radio<String>(
                                value: '6',
                                activeColor: Color.fromRGBO(218, 4, 32, 1),
                                groupValue: _newValue,
                                onChanged: (value) {
                                  setState(() {
                                    _newValue = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              margin: EdgeInsets.only(left: 10, right: 60),
                              child: Text(
                                "6个月",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "￥288",
                              style: TextStyle(
                                  color: Color.fromRGBO(218, 4, 32, 1),
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(249, 244, 255, 1)))),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Radio<String>(
                                value: '7',
                                activeColor: Color.fromRGBO(218, 4, 32, 1),
                                groupValue: _newValue,
                                onChanged: (value) {
                                  setState(() {
                                    _newValue = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              margin: EdgeInsets.only(left: 10, right: 60),
                              child: Text(
                                "7天体验",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "￥28.8",
                              style: TextStyle(
                                  color: Color.fromRGBO(218, 4, 32, 1),
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  //计时器
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(249, 244, 255, 1)))),
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
                            style:
                                TextStyle(color: Color.fromRGBO(218, 4, 32, 1)),
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
                                color: Color.fromRGBO(249, 244, 255, 1)))),
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
                              "image/weipay@2x.png",
                              width: 100,
                              height: 20,
                            ),
                          ),
                          Container(
                            child: Text(
                              "微信支付",
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
                height: 45,
                width: width,
                child: GestureDetector(
                  child: Container(
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
                    alipay();
                  },
                ),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    ));
  }

  var _payInfo, _payResult;
  void _loadData() {
    _payInfo = "";
    _payResult = {};
    http
        .post("http://120.79.190.42:8071/pay/test_pay/create",
            body: json.encode({"fee": 1, "title": "test pay"}))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        print(response.body);
        var map = json.decode(response.body);
        int flag = map["flag"];
        if (flag == 0) {
          var result = map["result"];
          setState(() {
            _payInfo = result["credential"]["payInfo"];
          });
          return;
        }
      }
      throw new Exception("创建订单失败");
    }).catchError((e) {
      setState(() {
        _payInfo = e.toString();
      });
    });

    setState(() {});
  }

  Future alipay() async {
//    _loadData();
    print(_payInfo);
    FormData param = FormData.from({"userId": await Tinker.getuserID()});
    final res = await http
        .post("http://192.168.1.57:8080/springcase8_war/alipay/payInfo");
    var data = json.decode(res.body);
    print(data);
    print("asd");
//        int.parse((new DateTime.now().millisecondsSinceEpoch).toString());
//    print(timeStamp);
//    String _payInfo =
//        "app_id=2019081366206450&biz_content{'out_trade_no':'20150320010101009','total_amount':'88.0','subject':'标题'}&charset=utf-8&method=alipay.trade.create&sign_type=RSA2&timestamp=1566236389588&version=1.0&sign=W2QUz6R8AoqCGgQIHYRGPSWyf3rf/Nv/XZBqO7rfJ/ziZ42RYnYcrExdcdzdQkBdGlF8pU0AksLdXnmsN4rNf/nrwv5z7PcA9UOmSXKJMDWRfpoiYRwxKHXfWYZG1BYge/v0NuxTIim7tOMASoua87zNRUUubX7pPvM96JRkQt5OjxZElR7QD3UmM2abN80YINJm76CocNVxC+3AtuQP2yGNJCXXb2fTQrxOPb6NqTMuKkea/5gCwwVUUvk3tQdjxkfI0k8tf5NAkw0wh/cJ98upRa5FL25Ot8Fi4C+1Ct/vSCmkwf3aDxnIGhgXch4Qkn1mqbit9fiax4rCVE903Q==";
    var payResult = await tobias.pay(data["rows"]["data"]);
    print(payResult);
    print("结果");
    if (payResult["resultStatus"] == "9000") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TinkerScaffold()),
          (route) => route == null);
    }
    tobias.isAliPayInstalled().then((data) {
      print("installed $data");
      Tinker.toast("支付成功");
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

  @override
  void initState() {
    super.initState();
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
