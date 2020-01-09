import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';

import 'package:flutter_study_app/pages/webview.dart';
import 'package:flutter_study_app/pages/index.dart';
import 'package:flutter_study_app/pages/ui/basic/safearea.dart';
import 'package:flutter_study_app/pages/demo/index/npc.dart';
import 'package:flutter_study_app/pages/demo/index/npc_info.dart';

import 'package:flutter_study_app/pages/game/gomoku/index.dart';

class MyRouter extends Router {
  // @override
  // bool pop(BuildContext context) {
  //   if (Navigator.of(context).canPop()) {
  //     return this.pop(context);
  //   }
  //   return false;
  // }
}

class Routes {
  static MyRouter _router;
  static String index = IndexPage.routerName;
  static String safearea = SafeAreaPage.routerName;
  static String webview = WebviewPage.routerName;

  static String demoIndex = DemoIndexPage.routerName;
  static String npcInfo = NpcInfoPage.routerName;

  static String gomoku = GomokuPage.routerName;

  static void configRoutes(MyRouter router) {
    _router = router;

    defineRoute(index, handler: IndexPage.handler(), transitionType: TransitionType.native);
    defineRoute(safearea, handler: SafeAreaPage.handler(), transitionType: TransitionType.native);
    defineRoute(webview, handler: WebviewPage.handler(), transitionType: TransitionType.native);

    defineRoute(demoIndex, handler: DemoIndexPage.handler());
    defineRoute(npcInfo, handler: NpcInfoPage.handler());

    defineRoute(gomoku, handler: GomokuPage.handler());
  }

  static defineRoute(
    String routePath,
    {
      Handler handler,
      TransitionType transitionType = TransitionType.native
    }
  ) {
    _router.define(routePath, handler: handler, transitionType: transitionType);
  }
}
