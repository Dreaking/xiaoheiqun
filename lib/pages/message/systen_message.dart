import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/message/sys_msg_detail.dart';
import 'package:xiaoheiqun/data/sys_msg.dart';

class systemMsg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return systemState();
  }
}

class systemState extends State<systemMsg> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDdta();
  }

  List movies;
  var userId, title, content, createTime;
  Future getDdta() async {
    userId = await Tinker.getuserID();
//    Tinker.toast(userId);
    FormData param = FormData.from({"userId": userId, "type": "0"});
    Tinker.post("/api/system/findSysMessage", (data) {
//      Tinker.toast("z");
//      setState(() {
//        title = data["rows"]["title"];
//        content = data["rows"]["content"];
//        createTime = data["rows"]["createTime"];
//      });
      List top = data["rows"];
      int a = int.parse(data["size"]);
      setState(() {
        movies = top.map((json) => sys_msg.fromJson(json)).toList();
      });
      print(title);
    }, params: param);
  }

  Future<Null> _refresh() async {
    getDdta();
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
            ? Center(
                child: Text("暂无数据"),
              )
            : ListView.builder(
                itemCount: movies.length,
                padding: EdgeInsets.only(top: 5),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Image.asset(
                                  "image/logo@2x.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Container(
                                width: width - 100,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromRGBO(
                                                238, 238, 238, 1)))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          movies[index].title,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                          child: Text(
                                            movies[index]
                                                .createTime
                                                .split(" ")[0],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color.fromRGBO(
                                                    155, 155, 155, 1)),
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: 160,
                                      height: 30,
                                      child: Text(
                                        movies[index].content,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color.fromRGBO(
                                                155, 155, 155, 1)),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        sys_msg_detail(movies[index])));
                          },
                        )
                      ],
                    ),
                  );
                }),
        onRefresh: _refresh);
  }
}
