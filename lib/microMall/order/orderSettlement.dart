import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class orderSettlement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return orderSettlementState();
  }
}

class orderSettlementState extends State<orderSettlement> {
  TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            title: Text(
              "订单结算",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
            ),
          ),
          preferredSize: Size(size.width, 50)),
      body: GestureDetector(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30),
                          vertical: ScreenUtil().setHeight(30)),
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setWidth(40),
                          right: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "某先生",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(117)),
                                    child: Text(
                                      "125215216",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(40)),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.deepOrange),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      "默认",
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black12,
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(20)),
                            child: Text(
                              "山东省济南市天桥区胜利庄路17号",
                              style: TextStyle(color: Colors.black45),
                            ),
                          )
                        ],
                      ),
                    ), //顶部地址
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setWidth(40),
                          right: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black12)),
                            child: Image.asset(
                              "image/img5.png",
                              width: 80,
                              height: 80,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20))),
                          Container(
                            width: ScreenUtil().setWidth(676),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "九阳小黄人C906D便携式榨汁机家用小型电动果汁机[下单送一盒紫薯豆料]",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(40))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text("￥599.00",
                                          style: TextStyle(
                                              color: Colors.deepOrange)),
                                    ),
                                    Text(
                                      "X1",
                                      style: TextStyle(color: Colors.black45),
                                    )
                                  ],
                                )
                              ],
                            ), //右侧商品描述
                          ),
                        ],
                      ),
                    ), //商品描述
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setWidth(40),
                          right: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            "image/vip@2x.png",
                            width: 50,
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "账号中没有会员卡",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black12,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), //会员卡
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setWidth(40),
                          right: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setHeight(20),
                                vertical: ScreenUtil().setHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset(
                                  "image/vip@2x.png",
                                  width: 50,
                                  height: 20,
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "暂无优惠卷卡用",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setHeight(20),
                                vertical: ScreenUtil().setHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "积分抵扣",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "使用积分抵扣",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), //Container优惠卷
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setWidth(40),
                          right: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "留言",
                              style: TextStyle(fontSize: 16),
                            ),
                            margin: EdgeInsets.only(top: 0),
                          ),
                          Container(
//                            decoration: BoxDecoration(
//                                border: Border.all(color: Colors.deepOrange)),
                              margin: EdgeInsets.only(left: 10, top: 0),
                              width: ScreenUtil().setWidth(825),
                              height: ScreenUtil().setHeight(300),
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                maxLines: 5,
                                controller: _controller,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: -2),
                                    hintStyle: TextStyle(fontSize: 16),
                                    hintText: "给卖家留言",
                                    border: InputBorder.none),
                              )),
                        ],
                      ),
                    ), //留言
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setWidth(40),
                          right: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("商品金额"),
                                Text(
                                  "￥599.00",
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("运费"),
                                Text(
                                  "￥0.00",
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("优惠"),
                                Text(
                                  "-￥0.00",
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("总金额："),
                                Text(
                                  "￥599.00",
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          ),
                        ],
                      ),
                    ), //商品信息详情
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    decoration: BoxDecoration(color: Colors.white),
                    height: ScreenUtil().setHeight(146),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("应付金额：￥599.00"),
                        Container(
                          width: ScreenUtil().setWidth(272),
                          height: ScreenUtil().setHeight(112),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "立即付款",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
