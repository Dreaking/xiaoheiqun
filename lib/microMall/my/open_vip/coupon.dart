import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Coupon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CouponState();
  }
}

class CouponState extends State<Coupon> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(251, 247, 242, 1),
              borderRadius: BorderRadius.circular(5)),
          width: ScreenUtil().setWidth(290),
          height: ScreenUtil().setHeight(130),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Container(
                height: double.infinity,
                width: ScreenUtil().setWidth(50),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                decoration: BoxDecoration(
                    color: Colors.orange[500],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: Text(
                  "立即领取",
                  style:
                      TextStyle(fontSize: 10, height: 1, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: ScreenUtil().setWidth(250),
            height: ScreenUtil().setHeight(130),
            decoration: BoxDecoration(
                color: Color.fromRGBO(251, 247, 242, 1),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text(
                    "300",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange[500],
                        fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.only(left: 10),
                ),
                Container(
                  width: ScreenUtil().setWidth(80),
                  child: Text(
                    "ktv专用卷",
                    style: TextStyle(
                        color: Colors.orange[400], height: 1, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ); //优惠卷;
  }
}
