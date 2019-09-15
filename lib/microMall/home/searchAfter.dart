import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAfter extends StatelessWidget {
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
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        child: Scaffold(
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
                  "搜索",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              preferredSize: Size(size.width, 50)),
          body: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width * 0.8,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(237, 237, 237, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Icon(Icons.search),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          width: size.width * 0.7,
                          height: 30,
                          child: TextField(
                            style: TextStyle(fontSize: 13),
                            cursorColor: Colors.black45,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "搜索",
                              contentPadding: EdgeInsets.only(top: -8),
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text("搜索")
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 0.5)),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "价格最高",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 70)),
                    Text(
                      "价格最低",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 10, top: 10),
              ), //历史记录
              Container(
                margin: EdgeInsets.only(top: 15),
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 0.5)),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Center(
                child: _wrapList(),
              )
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
