import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fluwx/fluwx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'app_config.dart';

class WxPay {
  static void register() {
    fluwx.register(appId: "wx7a3f09a16d6d1068");
  }

  static var prepayid;
  static var itemList;
  static void getPrice() {
    Tinker.post("/api/vip/findVipPrice", (data) {
      itemList = data["rows"];
    });
  }

  static void listen() {
    fluwx.responseFromShare.listen((response) {
      //do something
      print("分享的返回参数");
      if (response.errCode == 0) {
        Tinker.toast("分享成功");
      }
      print(response.errCode);
    });
    fluwx.responseFromAuth.listen((response) {
      //do something
    });
    fluwx.responseFromPayment.listen((response) {
      //do something
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
    fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;
    String _imagePath =
//  "http://img-download.pchome.net/download/1k1/3a/3e/ofskcd-s1a.jpg"
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534614311230&di=b17a892b366b5d002f52abcce7c4eea0&imgtype=0&src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170516%2F51296b2673704ae2992d0a28c244274c_th.png";
    String _thumbnail = "assets://images/logo.png";

    String _response = "";
    fluwx.isWeChatInstalled().then((data) {
      print(data); // always false
      if (data.toString() == "false") {
        Tinker.toast("未安装微信");
      } else {
        fluwx.share(fluwx.WeChatShareImageModel(
            image: _imagePath,
            thumbnail: _thumbnail,
            transaction: _imagePath,
            scene: scene,
            description: "image"));
      }
    });
  }
}
