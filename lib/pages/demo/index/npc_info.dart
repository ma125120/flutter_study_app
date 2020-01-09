import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_app/utils/http/API.dart';
import 'package:flutter_study_app/models/index.dart';
import 'package:flutter_study_app/extend/app.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_study_app/utils/index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NpcInfoPage extends StatefulWidget {
  static String routerName = '/demo/index/npc/info';
  static handler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return NpcInfoPage();
      },
    );
  }
  @override
  _NpcInfoPageState createState() => _NpcInfoPageState();
}

class _NpcInfoPageState extends State<NpcInfoPage> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;
  SwiperController _swiperController;
  final double topHeight = 500.0;

  bool isShowTitle = false;
  double opacity = 0.0;
  List<Npc> npcList = [];
  List<Widget> tabs = [
    Text('最近'),
    Text('档案'),
  ];

  List items = List.generate(20, (idx) => idx);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback){
      print(getParams(context));
    });

    _tabController = TabController(vsync: this, length: tabs.length);
    _swiperController = SwiperController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      setState(() {
        isShowTitle = offset >= topHeight - Adapt.topHeight(true);
        opacity = min(1.0, max(0, offset + Adapt.topHeight(true) - topHeight) / kToolbarHeight);
      });
    });

    getNpcList();
  }

  getNpcList() async {
    StoryListRes res = await API.getStoryList();
    if (res != null) {
      setState(() {
        npcList = res.npcInfos;
      });
    }
  }

  @override
  dispose() {
    super.dispose();
    _tabController.dispose();
    _swiperController.dispose();
    _scrollController.dispose();
  }

  get _renderFlexSpace {
    return ScrollHeader(
      child: Column(children: <Widget>[
        Container(height: Adapt.navbarHeight,),
        RaisedButton(
          child: Text('跳转本页面',),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.npcInfo, arguments: { 'id': '213' });
          },
        )
      ],),
      isShowTitle: isShowTitle,
      // title: Text(getParams(context, 'id') ?? 'title'),
      context: context,
      topHeight: topHeight,
      opacity: opacity,
      image: myImage('https://test-woof.heywoof.com/file/dGltZyAoNCkuanBlZw=='),
    );
  }

  get _renderTitle {
    return MyFadeHeader(
      child: Text(getParams(context, 'id') ?? 'title'),
      opacity: opacity,
      show: isShowTitle,
    );
  }

  get _renderSwiper {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500.0,
      child: Swiper(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            color: Color(0xFF82B1FF),
            child: Center(child: Text('$index', style: TextStyle(color: Colors.white, fontSize: 80.0),)),
          );
        },
        onIndexChanged: (index) {
          _tabController.index = index;
        },
        controller: _swiperController,
      ),
    );
  }

  // get _renderFlexSpaceMask {
  //   return Stack(
  //     children: <Widget>[
  //       Positioned()
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            // floating: true,
            pinned: true,
            // snap: true,
            expandedHeight: topHeight,
            title: _renderTitle,
            flexibleSpace: _renderFlexSpace,
            bottom: TabBar(
              tabs: tabs,
              labelPadding: EdgeInsets.only(bottom: 12.0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3.0,
              onTap: (int index) {
                _swiperController.move(index);
              },
              controller: _tabController,
            ),
          ),
          SliverToBoxAdapter(
            child: _renderSwiper,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, idx) {
              Npc item = npcList[idx];

              return Card(
                margin: EdgeInsets.only(top: 12.0, left: 20.0, right: 20.0, bottom: idx == npcList.length - 1 ? 12.0 : 0.0),
                color: Colors.white,
                child: Container(padding: EdgeInsets.all(12.0), child: Row(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(item.image),
                  ),
                  Container(child: Text(
                    npcList[idx]?.name ?? '', 
                    softWrap: true, 
                    // style: TextStyle(),
                    // overflow: TextOverflow.clip,
                  ), padding: EdgeInsets.only(left: 20.0),),
                ],
                mainAxisSize: MainAxisSize.min,))  
              );
            }, childCount: npcList.length),
          )
        ],
      )),
    );
  }
}
