import 'package:flutter/material.dart';
import 'package:flutter_base_demo/app_lifecycle.dart';
import 'package:flutter_base_demo/flutter_layout_page.dart';
import 'package:flutter_base_demo/flutter_widget_lifecycle.dart';
import 'package:flutter_base_demo/gesture_page_dart.dart';
import 'package:flutter_base_demo/less_group_page.dart';
import 'package:flutter_base_demo/plugin_use.dart';
import 'package:flutter_base_demo/res_page.dart';
import 'package:flutter_base_demo/stateful_group_page.dart';

import 'launch_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('如何创建和使用Flutter的路由与导航？'),
        ),
        body: RouterNavigator(),
      ),
      routes: <String, WidgetBuilder>{
        'plugin': (BuildContext context) => PluginUse(),
        'less': (BuildContext context) => LessGroupPage(),
        'ful': (BuildContext context) => StateFulGroup(),
        'layout': (BuildContext context) => FlutterLayoutPage(),
        'gesture': (BuildContext context) => LaunchPage(),
        'res': (BuildContext context) => ResPage(),
        'launch': (BuildContext context) => LaunchPage(),
        'widgetLifecycle': (BuildContext context) => WidgetLifecycle(),
        'appLifecycle': (BuildContext context) => AppLifecycle(),
      },
    );
  }
}

class RouterNavigator extends StatefulWidget {
  @override
  _RouterNavigatorState createState() => _RouterNavigatorState();
}

class _RouterNavigatorState extends State<RouterNavigator> {
  // 标记是否通过路由名名跳转路由
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
              value: byName,
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              },
              title: Text('${byName ? '' : '不'}通过路由名跳转')),
          item('如何使用Flutter包和插件', PluginUse(), 'plugin'),
          item('StatelessWidget与基础组件', LessGroupPage(), 'less'),
          item('StatefulWidget与基础组件', StateFulGroup(), 'ful'),
          item('如何进行Flutter布局开发', FlutterLayoutPage(), 'layout'),
          item('如何检测用户手势以及处理点击事件', GesturePage(), 'gesture'),
          item('如何导入和使用Flutter的资源文件', ResPage(), 'res'),
          item('如何打开第三方应用', LaunchPage(), 'launch'),
          item('Flutter页面生命周期', WidgetLifecycle(), 'widgetLifecycle'),
          item('Flutter应用生命周期', AppLifecycle(), 'appLifecycle'),
        ],
      ),
    );
  }

  item(String title, page, String routerName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routerName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
