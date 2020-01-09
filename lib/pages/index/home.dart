import 'package:flutter/material.dart';
import 'package:flutter_study_app/pages/ui/basic/safearea.dart';
import 'package:flutter_study_app/router/index.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('init home');
  }

  Widget get _renderBody {
    return Column(children: <Widget>[
      RaisedButton(
        child: Text('safearea'),
        onPressed: () {
          Navigator.of(context).pushNamed(SafeAreaPage.routerName);
        },
      ),
      RaisedButton(
        child: Text('五子棋'),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.gomoku);
        },
      ),
    ],);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: Scaffold(
        appBar: AppBar(title: Text('home'),),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: _renderBody,
        ) 
      ),
    );
  }
}