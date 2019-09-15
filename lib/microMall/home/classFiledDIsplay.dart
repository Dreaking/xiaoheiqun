import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class classFiledDisplay extends StatelessWidget {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              child: AppBar(
                elevation: 0,
                leading: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 18,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.white,
                title: Text(
                  "精品分类",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              preferredSize: Size(size.width, 50)),
          body: ListView(
            children: <Widget>[
              Center(
                child: _wrapList(),
              )
            ],
          )),
    );
  }
}
