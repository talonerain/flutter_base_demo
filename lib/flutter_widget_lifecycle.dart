import 'package:flutter/material.dart';

class WidgetLifecycle extends StatefulWidget {
  const WidgetLifecycle({Key key}) : super(key: key);

  /// 当我们构建一个新的statefulWidget时，这个方法会立即调用
  /// 并且这个方法是必须重写的
  @override
  _WidgetLifecycleState createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  int _count = 0;

  /// 这是创建Widget时调用的除构造方法外的第一个方法，类似于Android的onCreate()和ios的viewDidLoad()，
  /// 在这个方法中通常会做一些初始化工作，比如channel的初始化，监听器的初始化等
  @override
  void initState() {
    print('----initState----');
    super.initState();
  }

  /// 当依赖的State对象改变时会调用，在第一次构建widget时，在initState()之后会立即调用此方法；
  /// 如果StatefulWidget依赖于InheritedWidget，那么当InheritedWidget中的变量改变时会再次调用它。
  /// InheritedWidget可以高效地将数据在Widget树中向下传递、共享，可参考：https://book.flutterchina.club/chapter7/inherited_widget.html
  @override
  void didChangeDependencies() {
    print('----didChangeDependencies----');
    super.didChangeDependencies();
  }

  /// 这是一个必须实现的方法，在这里实现要呈现的内容，它会在didChangeDependencies()之后立即调用，
  /// 另外当在当前类中调用setState方法后也会再次调用该方法
  @override
  Widget build(BuildContext context) {
    print('----build----');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter页面生命周期'),
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              child: Text(
                '点我',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(_count.toString())
          ],
        ),
      ),
    );
  }

  /// 这是一个不常用到的生命周期方法，当父组件需要重新绘制时才会调用。该方法会携带一个oldWidget参数，
  /// 可以将其与当前的widget进行对比以便执行一些额外的逻辑
  @override
  void didUpdateWidget(covariant WidgetLifecycle oldWidget) {
    print('----didUpdateWidget----');
    super.didUpdateWidget(oldWidget);
  }

  /// 很少使用，在组件被移除时调用，在dispose之前调用
  @override
  void deactivate() {
    print('----deactivate----');
    super.deactivate();
  }

  /// 常用，组件被销毁时调用。通常在该方法中执行一些资源的释放工作，比如，监听器的卸载，channel的销毁等
  @override
  void dispose() {
    print('----dispose----');
    super.dispose();
  }
}
