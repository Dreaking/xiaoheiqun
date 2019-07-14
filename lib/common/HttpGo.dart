import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpController {
  //get方法
  static void get(String url, Function callback,
      {params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(AppConfig.AJAX_SERVER_API + url);

      if (callback != null) {
        var data = json.decode(res.body);
        if (data["statusCode"] == 200) {
          callback(data);
        } else {
          Tinker.toast(data["message"]);
        }
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  //post方法
  static void post(String url, Function callback,
      {params, Function errorCallback}) async {
    try {
      http.Response res =
          await http.post(AppConfig.AJAX_SERVER_API + url, body: params);

      if (callback != null) {
        callback(json.decode(res.body));
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }

  //查询用户信息
  static void queryUserInfo(userId, callback) {
    FormData p = FormData.from({'userId': userId, 'type': 0, 'fromUserId': ""});
    post(AppConfig.AJAX_SERVER_API + "/api/user/doUserMessage", (data) {
      callback(data["rows"]);
    }, params: p);
  }

  //保存本地用户信息
  static Future setStrong(object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("user", object);
  }

  //获取本地用户信息
  static getStrong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final obj = prefs.get("user");
    return obj;
  }
}
