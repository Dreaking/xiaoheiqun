import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class orderDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return orderDetailsState();
  }
}

class orderDetailsState extends State<orderDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            title: Text("订单详情"),
          ),
          preferredSize: Size(size.width, 50)),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(35))),
              Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35),
                    bottom: ScreenUtil().setWidth(35)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "image/img5.png",
                            width: 50,
                            height: 50,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            "交易关闭",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 15),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(42)),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text("XXXX"),
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Text("1244343434")
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(30)),
                          ),
                          Text(
                            "山东省济南市天桥区胜利庄路17号",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 12),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(42), bottom: 10),
                    )
                  ],
                ),
              ), //顶部交易信息
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                height: ScreenUtil().setHeight(650),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35),
                    bottom: ScreenUtil().setWidth(35)),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setHeight(30),
                          bottom: 1,
                          top: ScreenUtil().setHeight(20)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "子单编号：912309139128390128",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Divider(
                      height: 1.0,
                      indent: 0.0,
                      color: Colors.black12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Image.asset(
                          "image/img5.png",
                          width: ScreenUtil().setHeight(306),
                          height: ScreenUtil().setHeight(306),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10, top: ScreenUtil().setHeight(25)),
                          width: ScreenUtil().setWidth(630),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              Text("九阳小黄人C906D便携式榨汁机家用小型电动果汁机水果榨汁机"),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(75))),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("￥249"),
                                  Text(
                                    "x 1",
                                    style: TextStyle(color: Colors.black45),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 1.0,
                      indent: 0.0,
                      color: Colors.black12,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("商品金额"),
                              Text(
                                "￥249",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("运费"),
                              Text(
                                "￥0",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("优惠"),
                              Text(
                                "￥0",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          )
                        ],
                      ),
                    ), //Container 商品价格详情
                    Divider(
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("总金额："),
                          Text(
                            "￥249",
                            style: TextStyle(color: Colors.deepOrange),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ), //商品信息详情
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35),
                    bottom: ScreenUtil().setWidth(35)),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 2,
                            height: 12,
                            color: Colors.red,
                          ),
                          Text(
                            "订单信息",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "主单编号：",
                            style: TextStyle(color: Colors.black45),
                          ),
                          Text(
                            "9909809869790707",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                        left: 22,
                        top: 5,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "订单时间：",
                            style: TextStyle(color: Colors.black45),
                          ),
                          Text(
                            "2019-09-11 19:42:27",
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: 22, top: 5, bottom: 10),
                    ),
                  ],
                ),
              ), //订单信息
            ],
          ),
          Positioned(
              bottom: 0,
              height: ScreenUtil().setHeight(142),
              child: Container(
                color: Colors.white,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepOrange)),
                      width: ScreenUtil().setWidth(257),
                      height: ScreenUtil().setHeight(86),
                      child: Text(
                        "联系客服",
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
