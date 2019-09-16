import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiaoheiqun/microMall/home/classFiledDIsplay.dart';
import 'package:xiaoheiqun/microMall/home/productDetails.dart';
import 'package:xiaoheiqun/microMall/home/searchBefore.dart';

class HomeIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeIndexState();
  }
}

class HomeIndexState extends State<HomeIndex> {
  Widget _wrapList() {
    List<Widget> listWidget = new List();
    for (double i = 0; i < 9; i++) {
      listWidget.add(InkWell(
          child: Container(
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        width: ScreenUtil().setWidth(480),
        height: 235,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(
            bottom: 10.0,
            left: double.parse((i % 2.0).toString()) == 0 ? 0 : 10),
        child: Column(
          children: <Widget>[
            Image.asset(
              "image/img5.png",
              width: ScreenUtil().setWidth(375),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('『粉丝限量20台』九阳家用电蒸锅304不锈钢蒸笼'),
                Text(
                  '￥299',
                  style: TextStyle(
                    color: Colors.deepOrange,
//                      decoration: TextDecoration.lineThrough
                  ),
                )
              ],
            )
          ],
        ),
      )));
    }

    return Wrap(
      spacing: 2,
      children: listWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: InkWell(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(186, 186, 186, 1.0),
                    borderRadius: BorderRadius.circular(5)),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search),
                    Text(
                      "搜索",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SearchBefore()));
              },
            ),
          ),
          preferredSize: Size(size.width, 50)),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
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
                onTap: (index) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => productDetails()));
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
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.shop),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text("商城$index")
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => classFiledDisplay()));
                        },
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
                    "更多>",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "精品首发",
                    style: TextStyle(
                        color: Color.fromRGBO(238, 121, 44, 1), fontSize: 16),
                  ),
                  Text("更多>")
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
                    "更多>",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "剁手灵感",
                    style: TextStyle(
                        color: Color.fromRGBO(238, 121, 44, 1), fontSize: 16),
                  ),
                  Text("更多>")
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
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                            )
                          ]),
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
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "限量购物专区",
                style: TextStyle(
                    color: Color.fromRGBO(238, 121, 44, 1), fontSize: 17),
              ),
            ), //限量购物专区
            Container(
              height: 140,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "image/banner1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ), //广告
            Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: _wrapList(),
            )
          ],
        ),
      ), //SingleChildScollView
    );
  }
}
