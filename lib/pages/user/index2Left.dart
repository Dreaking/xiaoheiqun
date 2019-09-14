import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Renzheng.dart';
import 'package:xiaoheiqun/pages/main/recommder.dart';
import 'package:xiaoheiqun/pages/user/person_data.dart';

class index2Left extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return index2LeftState();
  }
}

class index2LeftState extends State<index2Left> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRecommder();
  }

  List renzhengMovies;
  var userId;
  //获得推荐人
  Future _getRecommder() async {
    userId = await Tinker.getuserID();
    print(userId);
    FormData param = FormData.from({"fromUserId": userId});
    if (userId != null) {
      Tinker.post("/api/user/doAllRenzhengUser", (data) {
        List top = data["rows"];
        setState(() {
          renzhengMovies = top.map((m) => Renzheng.fromJson(m)).toList();
        });
      }, params: param);
    }
  }

  Widget centerRecommender() {
    return userId == null
        ? Container()
        : renzhengMovies == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
                      width: double.infinity,
                      height: 250,
                      child: Container(
                        margin: EdgeInsets.only(left: 0, bottom: 10, top: 30),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: renzhengMovies.length,
                            itemBuilder: (context, index) {
                              return recommder(renzhengMovies[index]);
                            }),
                      ) //Container
                      ),
                  Positioned(
                      left: 10,
                      child: Text(
                        "为你推荐",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ); //返回推荐人
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "个人主页",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 15),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "分享的动态信息和照片都在你的个人主页中",
                    style: TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                    child: Text(
                      "快来编辑吧",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => person()));
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Text("发现新的朋友"),
          ),
          centerRecommender()
        ],
      ),
    );
  }
}
