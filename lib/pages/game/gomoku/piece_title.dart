import 'package:flutter/material.dart';
import 'package:flutter_study_app/extend/app.dart';

import './event_piece.dart';

class PieceTitle extends StatefulWidget {
  @override
  _PieceTitleState createState() => _PieceTitleState();
}

class _PieceTitleState extends State<PieceTitle> {
  bool isBlack = true;

  @override
  void initState() {
    super.initState();
    eventBus.on<PieceEvent>().listen((event) {
      setState(() {
        isBlack = event.isBlack;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(120),
      child: Center(child: Text('当前执棋方： ${isBlack ? "黑" : "白"}棋')),
      padding: EdgeInsets.only(top: Adapt.px(48), bottom: Adapt.px(24)),
    );
  }
}
