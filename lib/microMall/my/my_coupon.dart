import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class my_Coupon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return my_CouponState();
  }
}

class my_CouponState extends State<my_Coupon> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            title: Text("优惠卷"),
          ),
          preferredSize: Size(ScreenUtil().setWidth(1080), 50)),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black12),
                    bottom: BorderSide(color: Colors.black12))),
            width: ScreenUtil().setWidth(1080),
            height: 50,
            child: TabBar(
                indicatorWeight: 1,
                indicatorColor: Colors.black12,
                labelColor: Colors.orange[500],
                unselectedLabelColor: Colors.black,
                controller: tabController,
                tabs: <Widget>[Text("待使用"), Text("已使用"), Text("已过期")]),
          ),
          Expanded(
              child: TabBarView(controller: tabController, children: <Widget>[
            Icon(Icons.local_activity),
            Icon(Icons.local_activity),
            Icon(Icons.local_activity)
          ]))
        ],
      ),
    );
  }
}
