import 'package:flutter/material.dart';
// import 'package:flutter_study_app/pages/scroll/sliver.dart';
import 'package:flutter_study_app/pages/demo/index/npc.dart';

class DemoPage extends StatefulWidget {

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // print('init demo');
  }

  // Widget get _renderBody {
  //   return Text('demo');
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: Scaffold(
        // appBar: AppBar(title: Text('demo'),),
        body: DemoIndexPage(),
      ),
    );
  }
}