import 'package:flutter/material.dart';
// import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_study_app/utils/http/API.dart';
import 'package:flutter_study_app/models/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_study_app/extend/app.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:ui';

class DemoIndexPage extends StatefulWidget {
  static String routerName = '/demo/index';
  static handler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return DemoIndexPage();
      },
    );
  }

  @override
  _DemoIndexPageState createState() => _DemoIndexPageState();
}

class _DemoIndexPageState extends State<DemoIndexPage> {
  ScrollController _scrollController;
  GlobalKey _globalKey;
  final double topHeight = 500.0;

  bool isShowTitle = false;
  List<Npc> npcList = [];

  List items = List.generate(20, (idx) => idx);

  @override
  void initState() {
    super.initState();

    _globalKey = GlobalKey();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      setState(() {
        isShowTitle = offset >= topHeight - kToolbarHeight;
      });
    });

    getNpcList();
  }

  Future<List<Npc>> getNpcList() async {
    StoryListRes res = await API.getStoryList();
    if (res != null) {
      setState(() {
        npcList = res.npcInfos;
      });
      return res.npcInfos;
    }

    return null;
  }

  @override
  dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void toNpcInfo(id) {
    Navigator.of(context).pushNamed(Routes.npcInfo, arguments: { 'id': id, });
  }

  Widget _renderNpcItem(BuildContext context, int idx) {
    Npc item = npcList[idx];

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          toNpcInfo(item.id);
        },
        child: Container(
          padding: EdgeInsets.only(right: Adapt.px(16.0), left: Adapt.px(16.0),),
          child: Column(children: <Widget>[
            myAvatar(item.image, 64),
            _renderNpcText(item.name, padding: EdgeInsets.only(top: Adapt.px(12.0), bottom: Adapt.px(4.0),)),
            _renderNpcText(item.alias, color: MyColor.g3),
          ],),
        ),
      ),
    );
  }

  Widget _renderNpcText(String text, { Color color, num size, EdgeInsets padding }) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Text(text ?? '', 
        style: TextStyle(
          color: color,
          fontSize: size ?? Adapt.px(24.0),
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  get _renderBody {
    return EasyRefresh.custom(
      scrollController: _scrollController,
      header: PhoenixHeader(),
      footer: PhoenixFooter(),
      onRefresh: () async {
        // return true;
      },
      onLoad: () async {

      },
      slivers: <Widget>[
        
        SliverToBoxAdapter(
          child: Column(children: <Widget>[
            Container(height: 12.0),
            RaisedButton(
              child: Text('滚动到锚点'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                RenderBox box = _globalKey.currentContext.findRenderObject();
                // Size size = box.size;
                Offset offset = box.localToGlobal(Offset.zero);
                _scrollController.animateTo(_scrollController.offset + offset.dy - kToolbarHeight - MediaQueryData.fromWindow(window).padding.top, duration:Duration(milliseconds:500), curve: Curves.decelerate);
              },
            ),
            Container(height: 12.0),
          ],),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(top: Adapt.px(32), bottom: Adapt.px(0), left: Adapt.px(16), right: Adapt.px(16)),
            width: MediaQuery.of(context).size.width,
            height: Adapt.px(280.0),
            decoration: BoxDecoration(color: Colors.white),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: _renderNpcItem,
              itemCount: npcList.length,
              // padding: EdgeInsets.only(right: 12.0), // 无用
              primary: false,
              itemExtent: Adapt.px(160.0), // item 宽度
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              Container(
                key: _globalKey,
                height: 32.0,
                child: Text('锚点'),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, idx) {
            Npc item = npcList[idx];

            return myInk(
              onTap: () {
                toNpcInfo(item.id);
              },
                          child: Card(
                margin: EdgeInsets.only(top: 12.0, left: 20.0, right: 20.0, bottom: idx == npcList.length - 1 ? 12.0 : 0.0),
                color: Colors.white,
                child: Container(padding: EdgeInsets.all(12.0), child: Row(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: myImage(item.image),
                  ),
                  Container(child: Text(
                    npcList[idx]?.name ?? '', 
                    softWrap: true, 
                  ), padding: EdgeInsets.only(left: 20.0),),
                ],
                mainAxisSize: MainAxisSize.min,))  
              ),
            );
          }, childCount: npcList.length),
        ),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        appBar: AppBar(
          title: Text('npc'),
        ),
        body: _renderBody,
      )
    );
  }
}
