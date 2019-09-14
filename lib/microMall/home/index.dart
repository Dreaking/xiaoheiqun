import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeIndexState();
  }
}

class HomeIndexState extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Container(
                width: 200,
                child: TextField(
                  controller: new TextEditingController(),
                ),
              ),
            ),
            preferredSize: Size(size.width, 50)),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //轮播图
                Container(
                  child: Swiper(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        // 用Container实现图片圆角的效果
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: new AssetImage('image/banner1.png'), // 图片数组
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      );
                    },
                  ),
                  height: 200,
                ), //轮播图
                Container(
                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: 8,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, //显示区域宽高相等
                        childAspectRatio: 2 / 1.5,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
//                        decoration: BoxDecoration(
//                            border: Border.all(color: Colors.black)),
                          child: Column(
                            children: <Widget>[Icon(Icons.build), Text("每日幽默")],
                          ),
                        );
                      }),
                  height: 160,
                ), //分类类别选择
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Container(
                    height: 15,
                    color: Color.fromRGBO(242, 241, 246, 1),
                  ),
                ), //间隙
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: new AssetImage("image/banner2.png"),
                          fit: BoxFit.cover)),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 120,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Container(
                    height: 10,
                    color: Color.fromRGBO(242, 241, 246, 1),
                  ),
                ), //间隙
                Padding(padding: EdgeInsets.only(top: 5)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "更多",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "精品首发",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 16),
                      ),
                      Text("更多")
                    ],
                  ),
                ), //精品收发标题
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width,
                  height: 150,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: 280,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: new AssetImage('image/img5.png'), // 图片数组
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        );
                      }),
                ), //选择单品广告
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Container(
                    height: 10,
                    color: Color.fromRGBO(242, 241, 246, 1),
                  ),
                ), //间隙
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "更多",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "精品首发",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 16),
                      ),
                      Text("更多")
                    ],
                  ),
                ), //精品收发标题
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width,
                  height: 200,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 120,
                                height: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("image/img5.png"),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text("￥899.00"),
                                    Text("￥1599.00")
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ), //剁手灵感
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Container(
                    height: 10,
                    color: Color.fromRGBO(242, 241, 246, 1),
                  ),
                ), //间隙
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "限量购物专区",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 17),
                  ),
                ), //限量购物专区
                Container(
                  height: 140,
                  width: size.width - 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "image/banner1.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ), //广告
                Container(
                    height: 200,
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //横轴三个子widget
                            childAspectRatio: 1.0 //宽高比为1时，子widget
                            ),
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Icon(Icons.airport_shuttle),
                          Icon(Icons.all_inclusive),
                          Icon(Icons.beach_access),
                          Icon(Icons.cake),
                          Icon(Icons.free_breakfast)
                        ])),
              ], //children
            ), //Column
          ),
        ), //SingleChildScollView
      ),
    );
  }
}
