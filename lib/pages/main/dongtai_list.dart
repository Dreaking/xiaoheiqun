import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'dongtai_item.dart';

class DongtaiList extends StatefulWidget {
  int orderType;
  DongtaiList(
    this.orderType,
  ) : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DongtaiListState();
  }
}

class DongtaiListState extends State<DongtaiList> {
  List movies, addList;
  int homepage = 1;
  var userId, _control;
  void _listen() {
    _control = eventBus.on<UserLoggedInEvent>().listen((event) {
      setState(() {
        getData();
      });
    });
  }

  Future getData() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({
      "userId": userId == null ? "" : userId,
      "currentPage": homepage.toString(),
      "sortType": widget.orderType.toString(),
    });
    Tinker.post("api/product/findProductByPage", (data) {
      List top = data["rows"];
      setState(() {
        movies = top.map((json) => Animate.fromJson(json)).toList();
      });
    }, params: param);
  }

  List<Widget> dataList = List<Widget>();

//  @override
//  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  //下拉加载********
  List data;
  String listType;
  void _getMoretEvent() {
    homepage++;
    FormData param = FormData.from({
      "userId": userId == null ? "" : userId,
      "currentPage": homepage.toString(),
      "sortType": "2",
    });
    Tinker.post("api/product/findProductByPage", (data) {
      List top = data["rows"];
      addList = top.map((json) => Animate.fromJson(json)).toList();
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

  Future<Null> refresh() async {
    homepage = 1;
    getData();
    Tinker.toast("刷新成功");
  }

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _listen();
    // TODO: implement build
    return new SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollEndNotification>(
            // or  OverscrollNotification
            onNotification: (ScrollEndNotification scroll) {
              if (scroll.metrics.maxScrollExtent - scroll.metrics.pixels < 50) {
                // Scroll End
                print("我监听到我滑到底部了");
                _getMoretEvent();
              }
            },
            child: RefreshIndicator(
                child: movies == null
                    ? Center(child: CircularProgressIndicator())
                    : movies.toString() == "[]"
                        ? Center(
                            child: Text("暂无数据"),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(top: 5),
//                    physics: NeverScrollableScrollPhysics(),
                            itemCount: movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DongtaiItem(movies[index]);
                            },
                            //                controller: _scrollController,
                          ),
                onRefresh: refresh),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _control.cancel();
  }
}
