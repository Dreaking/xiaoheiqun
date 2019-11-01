import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/pages/main/user_detail.dart';

class ShoucangItem extends StatefulWidget {
  @override
  Animate animate;
  ShoucangItem(this.animate);
  State<StatefulWidget> createState() {
    return ShoucangItemState();
  }
}

class ShoucangItemState extends State<ShoucangItem> {
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
  List<Widget> imageList = List();

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
    for (var i = 0; i < widget.animate.img.length; i++) {
      if (widget.animate.img[i] != null)
        setState(() {
          imageList.add(Container(
            margin: EdgeInsets.only(bottom: 25),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: AppConfig.AJAX_IMG_SERVER + widget.animate.img[i],
              placeholder: (context, url) => new Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ));
        });
    }
  }

  Widget firstSwiperView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 440,
      child: Swiper(
        viewportFraction: 1,
        loop: false,
        itemCount: imageList.length,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                color: Colors.black54,
                activeColor: Colors.lightBlueAccent,
                size: 5,
                activeSize: 5)),
        controller: new SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: false,
        onTap: (index) {
          if (userId != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => udetail(widget.animate.id)));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          }
        },
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (imageList[index]);
  }

  Future getData() async {
    userId = await Tinker.getuserID();
  } //初始化数据

  bool T = true;
  //点击收藏的操作逻辑
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
      });
    } else {
      Tinker.post("/api/product/doCancelShoucangProduct", (data) {},
          params: param);
      Tinker.toast("取消收藏");
      setState(() {
        widget.animate.isShoucang = false;
      });
    }
    eventBus.fire(new ShouCangInEvent());
  } //收藏功能的实现

  List<Widget> Boxs() => List.generate(widget.animate.img.length, (index) {
        print(widget.animate.img[index]);
        print("aaaaccccc");
        if (widget.animate.img[index] != null) {
          return CachedNetworkImage(
            imageUrl: AppConfig.AJAX_IMG_SERVER + widget.animate.img[index],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          );
        }
        return Container();
      });

  @override
  Widget build(BuildContext context) {
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
                        width: 40,
                        height: 40,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: AppConfig.AJAX_IMG_SERVER +
                                widget.animate.headImg,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10, top: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border:
                                Border.all(color: Colors.black12, width: 0.6)),
                      ),
                    ],
                  ),
                  height: 50,
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
                  bottom: -2,
                  left: 25,
                ),
                Positioned(
                  child: widget.animate.isShoucang
                      ? Container()
                      : Image.asset(
                          "image/huangguan.png",
                          width: 30,
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
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  " " + widget.animate.title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                ),
              ],
            )),
          ],
        ), //Row
        Container(
          margin: EdgeInsets.only(left: 50),
          child: Wrap(
            spacing: 2, //主轴上子控件的间距
            runSpacing: 5, //交叉轴上子控件之间的间距
            children: Boxs(), //要显示的子控件集合
          ),
        )
      ],
    );
  }
}
