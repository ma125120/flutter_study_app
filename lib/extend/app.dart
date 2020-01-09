import 'package:flutter/material.dart';
// import 'package:fluro/fluro.dart';
import 'package:flutter_study_app/router/index.dart';
export 'package:flutter_study_app/router/index.dart';
export 'package:bot_toast/bot_toast.dart';

export 'package:flutter_study_app/utils/adapt.dart';
export 'package:flutter_study_app/utils/event_bus.dart';
export './const.dart';
export 'package:flutter_study_app/components/index.dart';

class Application {
  static MyRouter router;
  static pop(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
