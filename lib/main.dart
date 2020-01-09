import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluro/fluro.dart';
import 'package:bot_toast/bot_toast.dart';
import 'dart:io';

import 'package:flutter_study_app/router/watch.dart';

import 'package:flutter_study_app/pages/index.dart';
import 'package:flutter_study_app/router/index.dart';
import 'package:flutter_study_app/extend/app.dart';
import 'package:flutter_study_app/utils/http/API.dart';

void main() {
  runApp(MyApp());
  // 如果是Android设备，就执行下面的代码实现沉浸式状态栏
  if (Platform.isAndroid) {
      // 设置系统的沉浸式UI效果--把状态栏变成透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        // 应用这个效果
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
} 

class MyApp extends StatefulWidget {
  MyApp() {
    final router = MyRouter();
    Routes.configRoutes(router);

    Application.router = router;
    // Application.

    API.init();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        initialRoute: IndexPage.routerName,
        navigatorObservers: [
          BotToastNavigatorObserver(),
          MyWatchRoute(),
        ],
        onGenerateRoute: (settings) {
          return Application.router.generator(settings);
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color(0XFFF9F9F9),
          cardTheme: CardTheme(
            
          )
          // pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
        ),
      ),
    );
  }
}

