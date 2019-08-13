import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Renzheng.dart';

class authentationItem extends StatefulWidget {
  Renzheng renzheng;
  authentationItem(this.renzheng);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return authentationItemState();
  }
}

class authentationItemState extends State<authentationItem>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  void initView() {
    color_sel = int.parse(widget.renzheng.isShoucang);
    if (color_sel == 1) {
      setState(() {
        color_font = Colors.white;
        colors = Color.fromRGBO(255, 188, 1, 1);
        color_shoucang = "image/shoucang2.png";
        color_text = "已关注";
      });
    } else {
      setState(() {
        color_font = Colors.black;
        colors = Colors.white;
        color_text = "未关注";
        color_shoucang = "image/shoucang1.png";
      });
    }
  }

  @override
  bool get wantKeepAlive => false;
  var color_font = Colors.black;
  var colors = Colors.white;
  var color_sel;
  var color_text = "未关注";
  var color_shoucang = "image/shoucang1.png";

  var userId;
  Future shoucang1() async {
    userId = await Tinker.getuserID();
    FormData param =
        FormData.from({"userId": userId, "merchantId": widget.renzheng.userId});
    if (color_sel == 0) {
      setState(() {
        color_sel = 1;
        color_font = Colors.white;
        colors = Color.fromRGBO(255, 188, 1, 1);
        color_shoucang = "image/shoucang2.png";
        color_text = "已关注";
      });
      print(widget.renzheng.userId);
      Tinker.post("/api/system/doShoucangMerchant", () {}, params: param);
    } else {
      setState(() {
        color_sel = 0;
        color_font = Colors.black;
        colors = Colors.white;
        color_text = "未关注";
        color_shoucang = "image/shoucang1.png";
      });
      Tinker.post("/api/system/doCancelShoucangMerchant", () {}, params: param);
    }
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 85,
      //单个item
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //头像
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: 30,
            ),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.black12)),
            child: ClipOval(
              child: widget.renzheng.headImg == null
                  ? Image.asset(
                      "image/nologin@2x.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                      imageUrl:
                          AppConfig.AJAX_IMG_SERVER + widget.renzheng.headImg,
                      placeholder: (context, url) => new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
            ),
          ),
          //右侧信息
          Container(
            margin: EdgeInsets.only(right: 20),
            width: width * 0.7,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(242, 242, 242, 1)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //中间信息
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.renzheng.userName,
                              style: TextStyle(fontSize: 17),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: widget.renzheng.vipType == "1"
                                        ? Image.asset(
                                            "image/vip@2x.png",
                                            width: 20,
                                            height: 10,
                                          )
                                        : null,
                                  ),
                                  Container(
                                    child: widget.renzheng.isRenzheng == "1"
                                        ? Row(
                                            children: <Widget>[
                                              Image.asset(
                                                "image/renzheng.png",
                                                width: 20,
                                                height: 10,
                                              ),
                                              Text(
                                                "已认证",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )
                                        : null,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      new Container(
                                        child: Image.asset(
                                          "image/age@2x.png",
                                          height: 10,
                                        ),
                                        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      ),
                                      new Text(widget.renzheng.age.toString()),
                                    ],
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                ),
                                new Container(
                                  child: widget.renzheng.sex == "0"
                                      ? new Row(
                                          children: <Widget>[
                                            new Container(
                                              child: Image.asset(
                                                "image/male@2x.png",
                                                height: 10,
                                              ),
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                            ),
                                            new Text("男"),
                                          ],
                                        )
                                      : new Row(
                                          children: <Widget>[
                                            new Container(
                                              child: Image.asset(
                                                "image/female@2x.png",
                                                height: 10,
                                              ),
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                            ),
                                            new Text("女"),
                                          ],
                                        ),
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //聊天和关注
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Image.asset(
                                "image/liaotian.png",
                                width: 15,
                                height: 15,
                              ),
                            ),
                            Text(
                              "和TA聊天",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: colors,
                            borderRadius: BorderRadius.circular(5),
                            border: color_sel == 0
                                ? Border.all(color: Colors.black)
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  color_shoucang,
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                              Text(
                                "$color_text",
                                style:
                                    TextStyle(fontSize: 12, color: color_font),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          shoucang1();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
