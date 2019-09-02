import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Renzheng.dart';

class recommder extends StatefulWidget {
  Renzheng renzheng;
  recommder(this.renzheng);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return recommderState();
  }
}

class recommderState extends State<recommder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  //初始化关注未关注
  void initView() {
    color_sel = int.parse(widget.renzheng.isShoucang);
    if (color_sel == 1) {
      setState(() {
        color_font = Colors.black;
        colors = Colors.white;
        color_text = "已关注";
      });
    } else {
      setState(() {
        color_font = Colors.white;
        colors = Colors.lightBlueAccent;
        color_text = "关注";
      });
    }
  }

  var color_font = Colors.black;
  var colors = Colors.white;
  var color_sel, userId;
  var color_text = "关注";

  //点击关注操作
  Future shoucang1(id) async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId, "merchantId": id});
    if (color_sel == 0) {
      setState(() {
        color_sel = 1;
        color_font = Colors.black;
        colors = Colors.white;
        color_text = "已关注";
      });
      Tinker.post("/api/system/doShoucangMerchant", () {}, params: param);
    } else {
      setState(() {
        color_sel = 0;
        color_font = Colors.white;
        colors = Colors.lightBlueAccent;
        color_text = "关注";
      });
      Tinker.post("/api/system/doCancelShoucangMerchant", () {}, params: param);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(color: Colors.white),
      width: 149,
      height: 200,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(70)),
            margin: EdgeInsets.only(top: 15),
            child: ClipOval(
              child: CachedNetworkImage(
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                imageUrl: AppConfig.AJAX_IMG_SERVER + widget.renzheng.headImg,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          Text(widget.renzheng.userName),
          Text("粉丝：gemo0816"),
          GestureDetector(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: colors,
                  borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, right: 10, top: 25),
              child: Text(
                color_text,
                style: TextStyle(color: color_font),
              ),
            ),
            onTap: () {
              shoucang1(widget.renzheng.userId);
            },
          ) //点击操作
        ],
      ),
    );
  }
}
