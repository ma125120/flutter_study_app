import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';

import './event_piece.dart';
import 'package:flutter_study_app/extend/app.dart';

class Piece extends StatefulWidget {
  final double width;
  final double x;
  final double y;
  final double gap;

  Piece({this.width, this.x, this.y, Key key})
      : gap = width / 16,
        super(key: key);

  @override
  _PieceState createState() => _PieceState();
}

class _PieceState extends State<Piece> {
  bool isBlack = true;
  List<Point> points = List.generate(15 * 15, (index) {
    return null;
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  tapCanvas(TapUpDetails details) {
    Offset pos = details.globalPosition;
    int x = ((pos.dx - widget.x) / widget.gap).round();
    int y = ((pos.dy - widget.y) / widget.gap).round();

    if (points[x * 15 + y] == null) {
      Point point =
          Point(color: isBlack ? Colors.black : Colors.white, x: x, y: y);
      points[x * 15 + y] = point;

      if (checkWin(point)) {
        showDialog(
            context: context, builder: showResult, barrierDismissible: false);
      } else {
        isBlack = isBlack ? false : true;
        eventBus.fire(PieceEvent(isBlack: isBlack));
      }

      setState(() {});
    }
  }

  bool checkWin(Point point) {
    bool isWin = false;

    int x = point?.x;
    int y = point?.y;
    Color color = point?.color;
    int count = 0;

    List<BaseOffset> offsets = [
      BaseOffset(x: 1, y: 0),
      BaseOffset(x: 0, y: 1),
      BaseOffset(x: 1, y: -1),
      BaseOffset(x: -1, y: -1),
    ];

    for (BaseOffset offset in offsets) {
      // 每次切换方向时，如果已经赢了，直接break；
      // 否则 重新计数
      if (isWin) break;
      count = 0;

      for (int i = -4; i <= 4; i++) {
        int _x = x + offset.x * i;
        int _y = y + offset.y * i;
        if (_x >= 0 && _x < 15 && _y >= 0 && _y < 15) {
          Point p1 = points[_x * 15 + _y];
          if (p1?.color == color) {
            count += 1;
            if (count >= 5) {
              isWin = true;
              break;
            }
          } else {
            count = 0;
          }
        }
      }
    }

    return isWin;
  }

  Widget showResult(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        '${isBlack ? "黑棋" : "白棋"}获胜',
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('重新开始'),
          onPressed: () {
            setState(() {
              points = List.generate(15 * 15, (index) {
                return null;
              });
            });
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text('退出'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.width;
    return GestureDetector(
      onTapUp: tapCanvas,
      child: CustomPaint(
        size: Size(width, width), //指定画布大小
        painter: _MyPainter(
          points: points,
          gap: widget.gap,
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  List<Point> points = [];
  double gap = 0.0;
  _MyPainter({
    this.points,
    this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;
    double radius = min(eWidth / 2, eHeight / 2) - 2;

    var paint = Paint()..isAntiAlias = true;

    points.forEach((point) {
      if (point != null) {
        paint
          ..style = PaintingStyle.fill
          ..color = point.color ?? Colors.black;

        canvas.drawCircle(
          Offset(point.x * gap + radius, point.y * gap + radius),
          radius,
          paint,
        );
      }
    });
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Point {
  final int x;
  final int y;
  final Color color;
  Point({this.x, this.y, this.color});
}

class BaseOffset {
  final int x;
  final int y;
  BaseOffset({this.x, this.y});
}
