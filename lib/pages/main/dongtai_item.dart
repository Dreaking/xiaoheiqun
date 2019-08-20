import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/pages/main/user_detail.dart';

class DongtaiItem extends StatefulWidget {
  @override
  Animate animate;
  DongtaiItem(this.animate);
  State<StatefulWidget> createState() {
    return DongtaiItemState();
  }
}

class DongtaiItemState extends State<DongtaiItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  var userId;
  Future initView() async {
    userId = await Tinker.getuserID();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Content(widget.animate),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      onTap: () {
        if (userId == null) {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Login()));
        } else
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => udetail(widget.animate.id)));
      },
    );
  }
}

class Content extends StatefulWidget {
  Animate animate;
  Content(this.animate);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentState();
  }
}

class ContentState extends State<Content> {
  var showImages = "image/shoucang1.png";
  var userId;
  int _imgIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      var isshou = widget.animate.isShoucang;
      print(isshou);
    });
    if (widget.animate.isShoucang) {
      setState(() {
        showImages = "image/shoucang2.png";
        _imgIndex = 1;
      });
    } else {
      setState(() {
        showImages = "image/shoucang1.png";
        _imgIndex = 0;
      });
    }
  }

  Future getData() async {
    userId = await Tinker.getuserID();
  }

  bool T = true;
  Future shoucang() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({
      "userId": userId == null ? "" : userId,
      "productId": widget.animate.id
    });
    if (!widget.animate.isShoucang) {
      Tinker.post("/api/product/doShoucangProduct", (data) {
        print(data);
      }, params: param);
      Tinker.toast("收藏成功");
      setState(() {
        widget.animate.isShoucang = true;
//        showImages = "image/shoucang2.png";
//        _imgIndex = 1;
      });
    } else {
      Tinker.post("/api/product/doCancelShoucangProduct", (data) {},
          params: param);
      Tinker.toast("取消收藏");
      setState(() {
//        showImages = "image/shoucang1.png";
//        _imgIndex = 0;
        widget.animate.isShoucang = false;
      });
    }
    eventBus.fire(new ShouCangInEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 35,
                        height: 35,
                        child: ClipOval(
                          child: Image.network(
                            "http://imgs.jiashilan.com/" +
                                widget.animate.headImg,
                            width: 35,
                            height: 35,
                            fit: BoxFit.fill,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10, top: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border:
                                Border.all(color: Colors.black12, width: 0.6)),
                      ),
                    ],
                  ),
                  height: 40,
                ),
                Positioned(
                  child: ClipOval(
                    child: Image.asset(
                      "image/vipicon.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                  bottom: -5,
                  left: 20,
                ),
                Positioned(
                  child: widget.animate.isShoucang
                      ? Container()
                      : Image.asset(
                          "image/huangguan.png",
                          width: 25,
                          height: 10,
                          fit: BoxFit.fill,
                        ),
                  top: 0,
                  left: 5,
                )
              ],
            ),
            Flexible(
                child: Row(
              children: <Widget>[
                Text(
                  widget.animate.merchantName,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: widget.animate.isRenzheng == "0"
                      ? null
                      : Image.asset(
                          "image/renzheng.png",
                          width: 20,
                          height: 10,
                        ),
                )
              ],
            )),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Text(
          widget.animate.title,
          style: TextStyle(
            fontSize: 16,
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: new Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: widget.animate.img[0] == null
                      ? Image.asset(
                          "image/img1.png",
                          width: width * 0.3,
                          height: 120,
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          width: width * 0.3,
                          height: 120,
                          fit: BoxFit.fill,
                          imageUrl:
                              AppConfig.AJAX_IMG_SERVER + widget.animate.img[0],
                          placeholder: (context, url) => new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              )
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: new Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: widget.animate.img[1] == null
                      ? new Image.asset(
                          "image/img1.png",
                          width: width * 0.3,
                          height: 120,
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          width: width * 0.3,
                          height: 120,
                          fit: BoxFit.fill,
                          imageUrl:
                              AppConfig.AJAX_IMG_SERVER + widget.animate.img[1],
                          placeholder: (context, url) => new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              )
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: new Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: widget.animate.img[2] == null
                      ? null
                      : CachedNetworkImage(
                          width: width * 0.3,
                          height: 120,
                          fit: BoxFit.fill,
                          imageUrl: "http://imgs.jiashilan.com/" +
                              widget.animate.img[2],
                          placeholder: (context, url) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              )
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    "image/liulan@2x.png",
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Text(
                  widget.animate.clickCount.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(0xff, 0xcc, 0xcc, 0xcc),
                  ),
                  overflow: TextOverflow.fade,
                  textDirection: TextDirection.rtl,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                ClipOval(
                  child: Image.asset(
                    "image/shijian@2x.png",
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Text(
                  widget.animate.createTime,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(0xff, 0xcc, 0xcc, 0xcc),
                  ),
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: widget.animate.isShoucang
                      ? Image.asset(
                          "image/shoucang2.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "image/shoucang1.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                  onTap: () {
                    if (userId == null) {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Login()));
                    } else
                      shoucang();
                  },
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Image.asset(
                  "image/liaotian.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
