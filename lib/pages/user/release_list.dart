import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/release.dart';
import 'package:xiaoheiqun/pages/main/user_detail.dart';

class release_list extends StatefulWidget {
  String status;
  release_list(this.status);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return release_listState();
  }
}

class release_listState extends State<release_list> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future del(productId) async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId, "productId": productId});
    Tinker.post("/api/product/doDeleteProduct", (data) {
      Tinker.toast("删除成功");
      getData();
    }, params: param);
  }

  var userId, headimg, vipType, name;
  int a;
  List movies;
  Future getData() async {
    userId = await Tinker.getuserID();
    FormData param1 = FormData.from({
      "userId": userId,
      "type": "0",
      "fromUserId": userId == null ? "" : userId
    });
    Tinker.post("/api/user/doUserMessage", (data) {
      setState(() {
        name = data["rows"]["userName"];
        headimg = data["rows"]["headImg"];
        vipType = data["rows"]["vipType"];
      });
    }, params: param1);
    FormData param =
        FormData.from({"merchantId": userId, "status": widget.status});
    Tinker.post("/api/product/findProductByMerchantId", (data) {
      List top = data["rows"];
      a = int.parse(data["size"]);
      setState(() {
        movies = top.map((json) => Release.fromJson(json)).toList();
      });
    }, params: param);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: movies == null
          ? Center(child: CircularProgressIndicator())
          : a == 0
              ? Center(
                  child: Text("暂无数据"),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    width: 6))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 8, bottom: 10),
                                      width: 50,
                                      height: 40,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: ClipOval(
                                              child: Image.network(
                                                "http://imgs.jiashilan.com/$headimg",
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                "image/vipicon.png",
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                            ),
                                            left: 26,
                                            top: 22,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      child: Text(
                                        name,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 30, top: 10),
                                    child: Image.asset(
                                      "image/delete_blank.png",
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    del(movies[index].id);
                                  },
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  //标签
                                  Container(
                                    alignment: Alignment.center,
                                    height: 26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            Color.fromRGBO(242, 242, 242, 1)),
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            "image/biaoqian.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                          margin: EdgeInsets.only(right: 7),
                                        ),
                                        Text(
                                          movies[index].biaoqian,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  16, 130, 255, 1)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      movies[index].content,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: movies[index].img[0] == null
                                        ? Container()
                                        : CachedNetworkImage(
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                "http://imgs.jiashilan.com/" +
                                                    movies[index].img[0],
                                            placeholder: (context, url) =>
                                                new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                new SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              ],
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),
                                          )),
                                Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: movies[index].img[1] == null
                                        ? Container()
                                        : CachedNetworkImage(
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                "http://imgs.jiashilan.com/" +
                                                    movies[index].img[1],
                                            placeholder: (context, url) =>
                                                new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                new SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              ],
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),
                                          )),
                                Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: movies[index].img[2] == null
                                        ? Container()
                                        : CachedNetworkImage(
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                "http://imgs.jiashilan.com/" +
                                                    movies[index].img[2],
                                            placeholder: (context, url) =>
                                                new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                new SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              ],
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),
                                          ))
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, bottom: 5, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  Flex(
                                    mainAxisSize: MainAxisSize.min,
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: Image.asset(
                                          "image/liulan@2x.png",
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2)),
                                      Text(
                                        movies[index].clickCount.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              0xff, 0xcc, 0xcc, 0xcc),
                                        ),
                                        overflow: TextOverflow.fade,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
                                      ClipOval(
                                        child: Image.asset(
                                          "image/shijian@2x.png",
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2)),
                                      Text(
                                        movies[index].createTime,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black12,
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    udetail(movies[index].id)));
                      },
                    );
                  }),
    );
  }
}
