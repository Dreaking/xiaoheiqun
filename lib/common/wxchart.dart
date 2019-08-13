import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fluwx/fluwx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'app_config.dart';

class WxPay {
  static void register() {
    fluwx.register(appId: AppConfig.WX_PAY_ID);
  }

  static var prepayid;
  static var itemList;
  static void getPrice() {
    Tinker.post("/api/vip/findVipPrice", (data) {
      itemList = data["rows"];
    });
  }

  static var targetMoney, targetMonth, targetType;
  //获取订单号
  static Future getPrepayid() async {
    getPrice();
    targetMoney = itemList[0]["money"];
    targetMonth = itemList[0]["month"];
    targetType = itemList[0]["type"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FormData param = FormData.from({
      "userId": prefs.get("user1"),
      "money": targetMoney,
      "month": targetMonth,
      "type": targetType.toString()
    });
    Tinker.post("/pay/wx/queryUnifiedOrder", (data) {
      print("111111111111112");
      print(data);
      prepayid = data["rows"]["unifiedOrderID"];
      print(prepayid);
      print("11111111111111");
      wpay();
    }, params: param);
  }

  //调用支付接口
  static void wpay() {
    var chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';
    var maxPos = chars.length - 1;
    int len = 32;
    var pwd = '';
    var random = Random();
    var timeStamp =
        int.parse((new DateTime.now().millisecondsSinceEpoch).toString());
    print(timeStamp);
    print("sssdsdsdsdsdsdsdsdsd");

    for (var i = 0; i < len; i++) {
      pwd += chars[random.nextInt(maxPos)];
    }
    var stringA = "appid=" +
        AppConfig.WX_PAY_ID +
        "&noncestr=" +
        pwd +
        "&package=" +
        "Sign=WXPay" +
        "&partnerid=" +
        AppConfig.WX_PAY_SHOP_ID +
        "&prepayid=" +
        prepayid +
        "&timestamp=" +
        timeStamp.toString();
    var stringSignTemp = stringA + "&key=" + AppConfig.WX_PAY_SECRET;
    var sign = Tinker.generateMd5(stringSignTemp).toUpperCase();
    fluwx
        .pay(
      appId: AppConfig.WX_PAY_ID,
      partnerId: AppConfig.WX_PAY_SHOP_ID,
      prepayId: prepayid,
      packageValue: "Sign=WXPay",
      nonceStr: pwd,
      timeStamp: timeStamp,
      sign: sign,
    )
        .then((data) {
      print("---》$data");
    });
  }

  static void SHare() {
    fluwx.share(WeChatShareTextModel(
        text: "text from fluwx",
        transaction: "transaction}",
        scene: fluwx.WeChatScene.TIMELINE));
  }
}
