import 'package:flutter/material.dart';
import 'package:flutter_study_app/utils/http/API.dart';
import 'package:flutter_study_app/models/index.dart';
import 'package:flutter_study_app/extend/app.dart';
class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  ScrollController _scrollController;
  final double topHeight = 500.0;

  bool isShowTitle = false;
  List<Npc> npcList = [];

  List items = List.generate(20, (idx) => idx);

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      setState(() {
        isShowTitle = offset >= topHeight - kToolbarHeight;
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
    _scrollController.dispose();
  }

  get _renderFlexSpace {
    return ScrollHeader(
      child: Text('', style: TextStyle(color: Colors.white),),
      isShowTitle: isShowTitle,
      title: Text('title'),
      context: context,
      topHeight: topHeight,
      image: myImage('https://test-woof.heywoof.com/file/dGltZyAoNCkuanBlZw=='),
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
            flexibleSpace: _renderFlexSpace,
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
