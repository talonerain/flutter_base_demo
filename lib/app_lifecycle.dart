import 'package:flutter/material.dart';

/// 如何获取Flutter应用维度生命周期
/// WidgetsBindingObserver：是一个Widgets绑定监听器，通过它我们可以监听应用的生命周期。
class AppLifecycle extends StatefulWidget {
  const AppLifecycle({Key key}) : super(key: key);

  @override
  _AppLifecycleState createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter应用生命周期'),
        leading: BackButton(),
      ),
      body: Container(
        child: Text('Flutter应用生命周期'),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
    if (state == AppLifecycleState.paused) {
      print('App进入后台');
    } else if (state == AppLifecycleState.resumed) {
      print('App进入前台');
    } else if (state == AppLifecycleState.inactive) {
      // 不常用，当App处于非活动状态，并且未接收用户输入时调用，比如：来电话。
      // 测试时发现在回调paused和resumed之前都会先回调inactive
      print('App非活动状态');
    }
  }
}
