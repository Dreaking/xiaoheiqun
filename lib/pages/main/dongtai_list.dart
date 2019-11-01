import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/Animate.dart';
import 'package:xiaoheiqun/data/Renzheng.dart';
import 'package:xiaoheiqun/data/User.dart';
import 'package:xiaoheiqun/pages/main/recommder.dart';
import 'package:xiaoheiqun/pages/user/index.dart';
import 'package:xiaoheiqun/pages/user/person_data.dart';
import 'dongtai_item.dart';

class DongtaiList extends StatefulWidget {
  int orderType; //查询的类别：2热门 3发布时间 4认证用户 5关注
  DongtaiList(
    this.orderType,
  ) : super();

  @override
  State<StatefulWidget> createState() {
    return DongtaiListState();
  }
}

class DongtaiListState extends State<DongtaiList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return Refresh(widget.orderType);
        },
      ),
    );
  }
}

class Refresh extends StatefulWidget {
  int orderType; //查询的类别：2热门 3发布时间 4认证用户 5关注
  Refresh(
    this.orderType,
  ) : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RefreshState();
  }
}

class RefreshState extends State<Refresh> {
  List movies, addList;
  int homepage = 1;
  var userId, _control;
  ScrollController _controller = new ScrollController();

  //初始化函数
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _controller.addListener(() {
      print(_controller.offset);
    });
    _getRecommder();
    getUserdata();
  }

  List renzhengMovies;
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

  User myuser;
  //加载个人信息
  Future getUserdata() async {
    userId = await Tinker.getuserID();
    if (userId != null) {
      Tinker.queryUserInfo(userId, (data) {
        print(data);
        print("ddddd");
        setState(() {
          myuser = User.fromJson(data);
        });
      });
    }
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

  //登录监听刷新状态
  void _listen() {
    _control = eventBus.on<UserLoggedInEvent>().listen((event) {
      setState(() {
        getData();
      });
    });
  }

  //上拉刷新
  Future<Null> refresh() async {
    homepage = 1;
    getData();
    Tinker.toast("刷新成功");
  }

  //初始化动态列表数据更新
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

  bool get wantKeepAlive => true;
  bool slide = false;
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    _listen();
    // TODO: implement build
    return
//      NotificationListener<ScrollEndNotification>(
//        // or  OverscrollNotification
//        onNotification: (ScrollEndNotification scroll) {
//          if (scroll.metrics.maxScrollExtent - scroll.metrics.pixels < 50) {
//            // Scroll End
//            print("我监听到我滑到底部了");
//            setState(() {
//              slide = true;
//            });
//            slide = false;
//            _getMoretEvent();
//            return false;
//          }
//          return true;
//        },
//        child:
        EasyRefresh(
      refreshFooter: ClassicsFooter(
          key: _footerKey,
          bgColor: Colors.white,
          textColor: Colors.pink,
          moreInfoColor: Colors.pink,
          showMore: true,
          noMoreText: '',
          moreInfo: '加载中',
          loadReadyText: '上拉加载....'),
      child: movies == null
          ? Center(child: CircularProgressIndicator())
          : movies.toString() == "[]"
              ? Center(
                  child: Text("暂无数据"),
                )
              : ListView.builder(
//                        shrinkWrap: true,
                  padding: EdgeInsets.only(top: 5),
//                        physics: NeverScrollableScrollPhysics(),
                  itemCount: movies.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return userId == null ? Container() : topRecommender();
                    } else if (index == 2) {
                      return userId == null ? Container() : centerRecommender();
                    } else {
                      int n;
                      if (index > 2) {
                        n = index - 2;
                      } else {
                        n = index - 1;
                      }
                      return DongtaiItem(movies[n]); //返回单个Item项目
                    }
                  },
                ),
      loadMore: () async {
        print('开始加载更多');
        for (double i = 0; i < 9; i++) {
          _getMoretEvent();
        }
      },
    );
  }

  Widget topRecommender() {
    return myuser == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            child: Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black12)),
                              child: ClipOval(
                                child: userId == null
                                    ? Image.asset(
                                        "image/nologin@2x.png",
                                        width: 50,
                                        height: 50,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: AppConfig.AJAX_IMG_SERVER +
                                            myuser.headImg,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ), //Container,
                          ), //InkWell
                          Text(userId == null ? "未登录" : myuser.userName)
                        ],
                      ), //Column
                      Padding(padding: EdgeInsets.only(left: 20)),
                    ],
                  ), //Row,
                ) //Container
                ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => person()));
            },
          ); //返回顶部的推荐人动态
  }

  Widget centerRecommender() {
    return renzhengMovies == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  width: double.infinity,
                  height: 250,
                  child: Container(
                    margin: EdgeInsets.only(left: 0, bottom: 10, top: 30),
                    child: ListView.builder(
                        controller: _controller,
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
