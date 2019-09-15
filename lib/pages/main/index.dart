import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/common/wxchart.dart';
import 'package:xiaoheiqun/data/Draft.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/microMall/home/index.dart';
import 'package:xiaoheiqun/microMall/main.dart';
import 'package:xiaoheiqun/pages/edit/index.dart';
import 'package:xiaoheiqun/pages/main/dongtai_list.dart';

class MainIndex extends StatefulWidget {
  @override
  State createState() {
    return MainIndexState();
  }
}

class MainIndexState extends State<MainIndex>
    with SingleTickerProviderStateMixin {
  List<Widget> _swiperList = List();
  void _getBanner() {
    Tinker.post("/api/adv/findAllBanner", (path) {
      paths = path["rows"][0]["imgUrl"];
      for (var i = 0; i < int.parse(path["size"]); i++) {
        setState(() {
          _swiperList.add(CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: AppConfig.AJAX_IMG_SERVER + path["rows"][i]["imgUrl"],
            placeholder: (context, url) => new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                )
              ],
            ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ));
        });
      }
    });
  }

  static var paths;
  int count = 0;
  double a = 0;

  List<String> _tabbarTitle = ["热门", "发布时间", "认证用户", "关注"];

  TabController _tabController;
  ScrollController _scrollViewController;

  DongtaiList _dongtaiList;

  int _tabBarIndex = 0;

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void initState() {
    super.initState();
    WxPay.register();
    _getBanner();
    initData();
    WxPay.listen();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(
      length: _tabbarTitle.length,
      vsync: this,
      initialIndex: _tabBarIndex,
    );
    _dongtaiList = DongtaiList(_tabBarIndex);
  }

  var userId;
  //更新用户信息
  Future initData() async {
    userId = await Tinker.getuserID();
  }

  Widget _createSwiper() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(bottom: 55.0),
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Tinker.createSwiper(
          widgetList: _swiperList,
        ),
      ),
    );
  }

  Widget _createTabbar() {
    return TabBar(
      tabs: _tabbarTitle.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(item),
        );
      }).toList(),
      controller: _tabController,
      isScrollable: true,
      indicatorColor: AppConfig.APP_COLOR_THEME,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2.0,
      unselectedLabelStyle: TextStyle(fontSize: 14.0),
      unselectedLabelColor: AppConfig.BOTTOM_TAB_BAR_COLOR,
      labelColor: AppConfig.BOTTOM_TAB_BAR_COLOR_SELECT,
      onTap: (index) => _switchTabBar(index),
    );
  }

  void _switchTabBar(index) {
    _tabBarIndex = index;
    setState(() {
      _dongtaiList = new DongtaiList(_tabBarIndex);
    });
  }

  Widget _createTabbarView() {
    return TabBarView(
      children: <Widget>[
        DongtaiList(2),
        DongtaiList(3),
        DongtaiList(4),
        DongtaiList(5)
      ],
      controller: _tabController,
    );
  }

  List<Widget> _headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        //1.在标题左侧显示的一个控件，在首页通常显示应用的 logo；在其他界面通常显示为返回按钮
//        leading: Icon(_selectedChoice.icon),

        //2. ? 控制是否应该尝试暗示前导小部件为null
        automaticallyImplyLeading: true,

        //3.当前界面的标题文字
//        title: Text(_selectedChoice.title),

        //4.一个 Widget 列表，代表 Toolbar 中所显示的菜单，对于常用的菜单，通常使用 IconButton 来表示；
        //对于不常用的菜单通常使用 PopupMenuButton 来显示为三个点，点击后弹出二级菜单
//        actions: <Widget>[
//          new IconButton(
//            // action button
//            icon: new Icon(choices[0].icon),
//            onPressed: () {
//              _select(choices[0]);
//            },
//          ),
//          new IconButton(
//            // action button
//            icon: new Icon(choices[1].icon),
//            onPressed: () {
//              _select(choices[1]);
//            },
//          ),
//          new PopupMenuButton<Choice>(
//            // overflow menu
//            onSelected: _select,
//            itemBuilder: (BuildContext context) {
//              return choices.skip(2).map((Choice choice) {
//                return new PopupMenuItem<Choice>(
//                  value: choice,
//                  child: new Text(choice.title),
//                );
//              }).toList();
//            },
//          )
//        ],

        //5.一个显示在 AppBar 下方的控件，高度和 AppBar 高度一样，
        // 可以实现一些特殊的效果，该属性通常在 SliverAppBar 中使用
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: _createSwiper(),
          collapseMode: CollapseMode.pin,
        ),

        //6.一个 AppBarBottomWidget 对象，通常是 TabBar。用来在 Toolbar 标题下面显示一个 Tab 导航栏
        bottom: _createTabbar(),

        //7.? 材料设计中控件的 z 坐标顺序，默认值为 4，对于可滚动的 SliverAppBar，
        // 当 SliverAppBar 和内容同级的时候，该值为 0， 当内容滚动 SliverAppBar 变为 Toolbar 的时候，修改 elevation 的值
        elevation: 4,

        //APP bar 的颜色，默认值为 ThemeData.primaryColor。改值通常和下面的三个属性一起使用
        backgroundColor: Colors.white,

        //App bar 的亮度，有白色和黑色两种主题，默认值为 ThemeData.primaryColorBrightness
        brightness: Brightness.dark,

        //App bar 上图标的颜色、透明度、和尺寸信息。默认值为 ThemeData().primaryIconTheme
        iconTheme: ThemeData().primaryIconTheme,

        //App bar 上的文字主题。默认值为 ThemeData（）.primaryTextTheme
        textTheme: ThemeData().accentTextTheme,

        //此应用栏是否显示在屏幕顶部
        primary: true,

        //标题是否居中显示，默认值根据不同的操作系统，显示方式不一样,true居中 false居左
        centerTitle: true,

        //横轴上标题内容 周围的间距
        titleSpacing: NavigationToolbar.kMiddleSpacing,

        //展开高度
        expandedHeight: 245,

        //是否随着滑动隐藏标题
        floating: true,

        //tab 是否固定在顶部
        pinned: true,

        //与floating结合使用
        snap: false,
      )
    ];
  }

  Future<Null> refresh() async {
    Tinker.toast("刷新成功");
  }

  ScrollController _controller = ScrollController();
  /*拍照*/
  Future _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      List img = new List();
      img.add(image);
      Draft draft = new Draft(img: img.toList());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditIndex(draft)));
//      setState(() {
//        imgList.add(image);
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                title: GestureDetector(
                  child: Text(
                    "我的小黄鱼",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    _controller.jumpTo(_controller.position.minScrollExtent);
                  },
                ),
                leading: InkWell(
                  child: Icon(
                    Icons.photo_camera,
                  ),
                  onTap: () {
                    if (userId != null) {
                      _takePhoto();
                    } else {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Login()));
                    }
                  },
                ),
                actions: <Widget>[
                  InkWell(
                    child: Container(
                      child: Icon(Icons.build),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MicroMall()));
                      eventBus.fire(setSlide(false));
//                      Tinker.toast("功能开发中");
                    },
                  ),
                  InkWell(
                    child: Container(
                      child: Icon(Icons.share),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onTap: () {
                      WxPay.SHare();
                    },
                  )
                ],
              ),
              preferredSize: Size.fromHeight(
                  MediaQuery.of(context).size.height *
                      0.05)), //PreferredSize设置AppBar的高度
          body: RefreshIndicator(child: DongtaiList(1), onRefresh: refresh)

          //ListView列表
          ),
    );
//      DefaultTabController(
//        length: _tabbarTitle.length,
//        child: Scaffold(
//          body: NestedScrollView(
//            controller: _scrollViewController,
//            headerSliverBuilder: _headerSliverBuilder,
//            body: _createTabbarView(),
//          ),
//        ));
  }

  //////////////////////////////
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
