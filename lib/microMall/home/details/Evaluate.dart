import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Evaluate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EvaluateState();
  }
}

class EvaluateState extends State<Evaluate> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 2340)..init(context);
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
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
                "商品评价",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16),
              ),
            ),
            preferredSize: Size(size.width, 50)),
        body: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("评价21条"),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          "image/img5.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Container(
                        width: size.width * 0.72,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "kong",
                              style: TextStyle(color: Colors.black45),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text("物流挺快，客服服务好，噪音小，不错哦！家里好多九阳的产品了。"),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "2019-04-14 06:28:12",
                                style: TextStyle(color: Colors.black45),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
