import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/pages/main/user_detail.dart';

class DongtaiItem extends StatefulWidget {
  @override
  Animate animate;

  DongtaiItem(this.animate);
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DongtaiItemState();
  }
}

class DongtaiItemState extends State<DongtaiItem> {
  var showImages = "image/shoucang1.png";

  int _imgIndex = 0;

  @override
  // TODO: implement wantKeepAlive
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: new Column(
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
                                      border: Border.all(
                                          color: Colors.black12, width: 0.6)),
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
                  new Container(
                    child: new Row(
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
                                    imageUrl: "http://imgs.jiashilan.com/" +
                                        widget.animate.img[0],
                                    placeholder: (context, url) => new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    imageUrl: "http://imgs.jiashilan.com/" +
                                        widget.animate.img[1],
                                    placeholder: (context, url) => new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            child: Image.asset(
                              "$showImages",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              if (_imgIndex == 0) {
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
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
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
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => udetail(widget.animate.id)));
      },
    );
  }
}
