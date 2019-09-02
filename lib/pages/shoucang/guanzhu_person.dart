import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/guanzhuUser.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/pages/main/other_dongtai.dart';

class guanzhuPerson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return guanzhuState();
  }
}

class guanzhuState extends State<guanzhuPerson> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List movies = null;
  var userId;
  Future getData() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId});
    Tinker.post("/api/product/findMerchantPageByUserId", (data) {
      List top = data["rows"];
      setState(() {
        movies = top.map((json) => guanzhuUser.fromJson(json)).toList();
      });
    }, params: param);
  }

  Future<Null> _refresh() async {
    getData();
    Tinker.toast("刷新成功");
    return;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return RefreshIndicator(
        child: movies == null
            ? Center(child: CircularProgressIndicator())
            : movies.toString() == "[]"
                ? Center(
                    child: Text("暂无数据"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 70,
                        //单个item
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //头像
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.black12)),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: 30,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    AppConfig.AJAX_IMG_SERVER +
                                        movies[index].headImg,
                                    height: 50,
                                    fit: BoxFit.fill,
                                    width: 50,
                                  ),
                                ),
                              ),
                              //右侧信息
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: width * 0.7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //中间信息
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  movies[index].userName,
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "image/vip@2x.png",
                                                        width: 20,
                                                        height: 10,
                                                      ),
                                                      Image.asset(
                                                        "image/renzheng.png",
                                                        width: 20,
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "已认证",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
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
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 5, 0),
                                                          ),
                                                          new Text(movies[index]
                                                              .age
                                                              .toString()),
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 15, 0),
                                                    ),
                                                    new Container(
                                                      child: movies[index]
                                                                  .sex ==
                                                              "0"
                                                          ? new Row(
                                                              children: <
                                                                  Widget>[
                                                                new Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "image/male@2x.png",
                                                                    height: 10,
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                ),
                                                                new Text("男"),
                                                              ],
                                                            )
                                                          : new Row(
                                                              children: <
                                                                  Widget>[
                                                                new Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "image/female@2x.png",
                                                                    height: 10,
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                ),
                                                                new Text("女"),
                                                              ],
                                                            ),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 15, 0),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        otherDongtai(movies[index].userId)));
                          },
                        ),
                      );
                    }),
        onRefresh: _refresh);
  }
}
