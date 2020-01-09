import 'package:flutter/material.dart';
import 'package:flutter_study_app/extend/app.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_study_app/pages/webview.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// import 'package:flutter_study_app/components/form/index.dart';

class SafeAreaPage extends StatefulWidget {
  static String routerName = '/ui/basic/safearea';
  static handler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return SafeAreaPage();
      },
    );
  }

  static Map info = {
    'url': 'https://api.flutter.dev/flutter/widgets/SafeArea-class.html',
    'title': 'safearea'
  };

  @override
  _SafeAreaPageState createState() => _SafeAreaPageState();
}

class _SafeAreaPageState extends State<SafeAreaPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  static Map info = {'minimum': 0.0, 'maintainBottomViewPadding': true, 'top': true, 'bottom': false, 'left': true, 'right': true };

  Widget _renderCard(String text, List<Widget> children) {
    return Column(
      children: <Widget>[
        Container(
          child: MyTitle(text),
          padding: EdgeInsets.only(top: 32.0, bottom: 12.0, left: 16+.0),
        ),
        Card(
          margin: EdgeInsets.all(0.0),
          child: Column(
            children: children,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _renderDisplayText(String text, BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);

    return  Container(
      width: query.size.width,
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0),
      child: Text(text + ' top: ${query.padding.top} bottom: ${query.padding.bottom}', style: TextStyle(color: Colors.white),),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  get _renderBody {
    Map values = _fbKey?.currentState?.value ?? info;

    List<FormBaseOption> formOptions = [
      FormBaseOption<num>(
        title: 'minimum', attr: 'minimum', type: 'number', 
        value: values['minimum'] ?? 0,
        max: 50,
      ),
      FormBaseOption<bool>(title: 'top', attr: 'top', value: values['top']),
      FormBaseOption<bool>(title: 'bottom', attr: 'bottom', value: values['bottom']),  
      FormBaseOption<bool>(title: 'left', attr: 'left', value: values['left']),  
      FormBaseOption<bool>(title: 'right', attr: 'right', value: values['right']),  
      FormBaseOption<bool>(title: 'maintainBottomViewPadding', attr: 'maintainBottomViewPadding', value: values['maintainBottomViewPadding']), 
    ];

    return FormBuilder(
      key: _fbKey,
      onChanged: (value) {
        setState(() {
          info = value;
        });
      },
      child: SafeArea(
        top: values['top'] ?? true,
        bottom: values['bottom'] ?? true,
        left: values['left'] ?? true,
        right: values['right'] ?? true,
        maintainBottomViewPadding: values['maintainBottomViewPadding'],
        minimum: EdgeInsets.all(values['minimum'] ?? 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _renderDisplayText('顶部的文字', context),
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                _renderCard('属性说明', [
                  ListTile(
                    title: Text('官方文档'),
                    onTap: () {
                      // Application.router.navigateTo(context, WebviewPage.routerName, );
                      Navigator.of(context).pushNamed(WebviewPage.routerName,
                          arguments: SafeAreaPage.info);
                    },
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ]),
                _renderCard('属性配置', [
                  ...formOptions.map(renderFormItem),
                ]),
              ]),
            )),
            _renderDisplayText('底部的文字', context),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: _renderBody,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      )
    );
  }
}
