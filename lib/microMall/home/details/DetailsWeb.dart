import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("商品详情"),
            ),
            Html(
                data:
                    "<img width='100%' height='auto' src='http://images.baixingliangfan.cn/shopGoodsDetailImg/20190109/20190109172624_1286.jpg' />"
                    "<img width='100%' height='auto'  src='http://images.baixingliangfan.cn/shopGoodsDetailImg/20190109/20190109172624_3721.jpg' />"
                    "<img width='100%' height='auto' src='http://images.baixingliangfan.cn/shopGoodsDetailImg/20190109/20190109172624_1286.jpg' />"
                    "<img width='100%' height='auto'  src='http://images.baixingliangfan.cn/shopGoodsDetailImg/20190109/20190109172624_3721.jpg' />"),
          ],
        ));
  }
}
