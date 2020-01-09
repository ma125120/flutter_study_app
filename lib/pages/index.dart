import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_study_app/pages/index/demo.dart';
import 'package:flutter_study_app/pages/index/home.dart';

class IndexPage extends StatefulWidget {
  static String routerName = '/';
  static handler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return IndexPage();
      },
    );
  }

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static int index = 0;

  final PageController _pageController = PageController();
  
  final List<Widget> pages = [
    HomePage(),
    DemoPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, index) {
            return pages[index];
          },
          itemCount: pages.length,
          controller: _pageController,
          onPageChanged: (idx) {
            setState(() {
              index = idx;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (idx) {
            _pageController.animateToPage(idx, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('demo'),
            ),
          ]
        ),
      )
    );
  }
}