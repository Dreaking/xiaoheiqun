import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/pages/main/dongtai_item.dart';
import 'package:xiaoheiqun/pages/shoucang/shoucangItem.dart';

class shoucangList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return shoucangListState();
  }
}

class shoucangListState extends State<shoucangList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  StreamSubscription _control;
//监听Bus events
  void _listen() {
    _control = eventBus.on<ShouCangInEvent>().listen((event) {
      setState(() {
        initView();
      });
    });
  }

  var userId;
  List movies;
  Future initView() async {
    userId = await Tinker.getuserID();
    FormData param = FormData.from({"userId": userId});
    if (userId != null) {
      Tinker.post("/api/product/findProductPageByUserId", (data) {
        List top = data["rows"];
        setState(() {
          movies = top.map((json) => Animate.fromJson(json)).toList();
        });
      }, params: param);
    }
  }

  Future<Null> refresh() async {
    initView();
    Tinker.toast("刷新成功");
    return;
  }

  @override
  Widget build(BuildContext context) {
    _listen();

    // TODO: implement build
    return new SafeArea(
        top: false,
        bottom: false,
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
                          return ShoucangItem(movies[index]);
                        },
                        //                controller: _scrollController,
                      ),
            onRefresh: refresh));
    ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _control.cancel();
  }
}
