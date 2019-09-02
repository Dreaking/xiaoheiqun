import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/test.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/edit/index.dart';
import 'package:xiaoheiqun/pages/user/index.dart';

class LeftPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeftPageViewState();
  }
}

class LeftPageViewState extends State<LeftPageView>
    with SingleTickerProviderStateMixin {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final PageController controller = PageController(initialPage: 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mController = TabController(length: 3, vsync: this, initialIndex: 1);
    mController.addListener(() {
      mController.index;
    });
  }

  final List<Widget> _pages = <Widget>[
//    EditIndex(null),
    testCM(),
    TinkerScaffold(),
    UserIndex()
  ];

  TabController mController;

  void _listen() {
    eventBus.on<setSlide>().listen((event) {
      setPhysics(event.slide);
    });
  }

  bool slide = true;
  //设定是否允许左右滑动
  void setPhysics(bool t) {
    setState(() {
      slide = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabBarView(
          controller: mController,
          children: _pages,
          physics: slide ? null : NeverScrollableScrollPhysics(),
        )
//      PageView.custom(
////        physics: NeverScrollableScrollPhysics(),
//        controller: controller,
//        childrenDelegate: new SliverChildBuilderDelegate(
//          (context, index) {
//            return _pages[index];
//          },
//          childCount: 3,
//        ),
//      ),
        );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
