import 'package:flutter/material.dart';

class WithKeyboard extends StatefulWidget {
  WithKeyboard({ this.child, });
  final Widget child;

  @override
  _WithKeyboardState createState() => _WithKeyboardState();
}

class _WithKeyboardState extends State<WithKeyboard> {

  double _safeAreaHeight;

  @override
  void initState() {
    super.initState();
    _safeAreaHeight = MediaQuery.of(context).padding.bottom;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0.0;
    if (isKeyboardVisible && _safeAreaHeight > 0.0) {
      setState(() {
        _safeAreaHeight = 0.0;
      });
    } else if (!isKeyboardVisible && _safeAreaHeight == 0.0) {
      setState(() {
        _safeAreaHeight = MediaQuery.of(context).padding.bottom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: _safeAreaHeight),
      child: widget.child,
    );
  }
}