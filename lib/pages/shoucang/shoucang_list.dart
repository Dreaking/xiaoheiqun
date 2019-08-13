import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/pages/main/dongtai_item.dart';

class shoucang_list extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return shoucangListState();
  }
}

class shoucangListState extends State<shoucang_list> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var userId;
  int homePage = 1;
  List movies;
  Future getData() async {
    setState(() {
      homePage++;
    });
    List addList;
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId, "currentPage": homePage});
    Tinker.post("/api/product/findMerchantPageByUserId", (data) {
      List top = data["rows"];
      setState(() {
        addList = top.map((json) => Animate.fromJson(json)).toList();
      });
      if (addList.length > 0) {
        for (var i = 0; i < addList.length; i++) {
          setState(() {
            movies.add(addList[i]);
          });
        }
      } else {
        Tinker.toast("暂无数据");
      }
    }, params: param);
  }

  Future<Null> _refresh() async {
    homePage = 1;
    getData();
    Tinker.toast("刷新成功");
    return;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollEndNotification>(
            // or  OverscrollNotification
            onNotification: (ScrollEndNotification scroll) {
              if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                // Scroll End
                print("我监听到我滑到底部了");
                getData();
              }
            },
            child: RefreshIndicator(
                child: movies == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 5),
//                    physics: NeverScrollableScrollPhysics(),
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DongtaiItem(movies[index]);
                        },
                        //                controller: _scrollController,
                      ),
                onRefresh: _refresh),
          );
        },
      ),
    );
  }
}
