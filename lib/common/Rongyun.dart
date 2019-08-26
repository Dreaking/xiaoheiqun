import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'package:dio/dio.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';

class Rongyun {
  static Future connectRongyun() async {
    Dio dio = new Dio();
    FormData param;
    var userId = await Tinker.getuserID();
    RongcloudImPlugin.init("pvxdm17jpo89r");
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
      Tinker.queryUserInfo(userId, (data) async {
        param = FormData.from({
          "userId": userId.toString(),
          "name": data["userName"].toString(),
          "portraitUri": AppConfig.AJAX_IMG_SERVER + data["headImg"].toString()
        });
        final res = await http.post(
            "http://api-cn.ronghub.com/user/getToken.json",
            body: param,
            headers: {
              "RC-App-Key": "pvxdm17jpo89r",
              "Nonce": pwd,
              "Timestamp": timeStamp.toString(),
              "Signature": digest.toString()
            });
        return json.decode(res.body)["token"];
//        int rc =
//            await RongcloudImPlugin.connect(json.decode(res.body)["token"]);
//        print(rc);
//        print('connect result');
      });
    }
  }
}
