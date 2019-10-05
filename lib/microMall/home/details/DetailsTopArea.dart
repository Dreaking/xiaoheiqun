import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              height: ScreenUtil().setHeight(1080),
              child: Swiper(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    // 用Container实现图片圆角的效果
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage('image/banner1.png'), // 图片数组
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                pagination: new SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                  size: 8,
                  activeSize: 8,
                  color: Colors.white,
                  activeColor: Colors.deepOrange,
                )),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "『粉丝限量200台』九阳家用电蒸锅304不锈钢蒸笼大容量R100-G10",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "304不锈钢蒸笼【原件239，粉丝价189，9.1-9.15，粉丝节向量购物200件】",
                    style: TextStyle(color: Colors.black45),
                  ),
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "￥189.00",
                      style: TextStyle(fontSize: 18, color: Colors.deepOrange),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    Text(
                      "￥299",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black45),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
