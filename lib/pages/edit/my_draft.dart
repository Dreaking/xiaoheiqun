import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Draft.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/pages/edit/index.dart';

class draft extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return draftState();
  }
}

class draftState extends State<draft> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  var userId, headimg, vipType, name;
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
      print(userId);
    }, params: param1);
    FormData param = FormData.from({"merchantId": userId});
    Tinker.post("/api/product/findCgProductByMerchantId", (data) {
      List top = data["rows"];
      int a = int.parse(data["size"]);
      setState(() {
        movies = top.map((json) => Draft.fromJson(json)).toList();
      });
    }, params: param);
  }

  void exit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            }),
        title: Text(
          "草稿",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
      body: movies == null
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
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, top: 8, bottom: 10),
                              width: 50,
                              height: 40,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
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
                                              BorderRadius.circular(25)),
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
                                style: TextStyle(fontSize: 18),
                              ),
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
                                    color: Color.fromRGBO(242, 242, 242, 1)),
                                width: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          color:
                                              Color.fromRGBO(16, 130, 255, 1)),
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
                                        imageUrl: "http://imgs.jiashilan.com/" +
                                            movies[index].img[0],
                                        placeholder: (context, url) => new Row(
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
                                        errorWidget: (context, url, error) =>
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
                                        imageUrl: "http://imgs.jiashilan.com/" +
                                            movies[index].img[1],
                                        placeholder: (context, url) => new Row(
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
                                        errorWidget: (context, url, error) =>
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
                                        imageUrl: "http://imgs.jiashilan.com/" +
                                            movies[index].img[2],
                                        placeholder: (context, url) => new Row(
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
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ))
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 5))
                      ],
                    ),
                  ),
                  onTap: () {
                    eventBus.fire(CaoClickInEvent(movies[index], 1));
                    Navigator.pop(context);
                  },
                );
              }),
    );
  }
}
