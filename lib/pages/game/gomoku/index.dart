import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_study_app/extend/app.dart';

import './checkerboard.dart';
import './piece.dart';
import './piece_title.dart';

class GomokuPage extends StatefulWidget {
  static String routerName = '/game/gomoku';
  static handler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return GomokuPage();
      },
    );
  }

  @override
  _GomokuPageState createState() => _GomokuPageState();
}

class _GomokuPageState extends State<GomokuPage> {
  GlobalKey _globalKey;

  double _x = 0;
  double _y = 0;

  static double bodyWidth = Adapt.w - Adapt.px(32 * 2);
  static double boardWidth = bodyWidth - bodyWidth / 16;
  // static double pieceWidth = bodyWidth - 24;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      RenderBox box = _globalKey.currentContext.findRenderObject();
      // Size size = box.size;
      Offset offset = box.localToGlobal(Offset.zero);
      setState(() {
        _x = offset.dx;
        _y = offset.dy;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('五子棋'),
        ),
        body: Container(
          color: Color(0xFFF2F2F2),
          child: FixedStack(
            body: Center(
              child: CheckerBoard(width: boardWidth, key: _globalKey),
            ),
            children: <Widget>[
              PieceTitle(),
              Center(
                child: Piece(
                  width: bodyWidth,
                  x: _x,
                  y: _y,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
