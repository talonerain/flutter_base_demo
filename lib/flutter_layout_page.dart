import 'package:flutter/material.dart';

///如何进行Flutter布局开发？
class FlutterLayoutPage extends StatefulWidget {
  @override
  _FlutterLayoutPageState createState() {
    // TODO: implement createState
    return _FlutterLayoutPageState();
  }
}

class _FlutterLayoutPageState extends State<FlutterLayoutPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: '如何进行Flutter布局开发？',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("如何进行Flutter布局开发？"),
          // 手势监听器
          leading: GestureDetector(
            onTap: () {
              // 跳进页面是push，跳出就是pop
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                title: Text('首页')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.list,
                  color: Colors.blue,
                ),
                title: Text('列表'))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Text('点我'),
        ),
        body: _currentIndex == 0
            ? RefreshIndicator(
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              //ClipOval：将布局裁剪成圆形
                              ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      'https://www.devio.org/img/avatar.png'),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  //ClipRRect：将布局裁剪成方形
                                  child: ClipRRect(
                                    //圆角
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    //Opacity：通常用来改变透明度的组件
                                    child: Opacity(
                                      opacity: 0.6, //60%透明度
                                      child: Image.network(
                                        'https://www.devio.org/img/avatar.png',
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          TextField(
                            //输入文本样式
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                hintText: '请输入',
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            // PhysicalModel：用来将布局显示成不同形状的组件
                            child: PhysicalModel(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              clipBehavior: Clip.antiAlias, //抗锯齿
                              child: PageView(
                                children: <Widget>[
                                  _item('Page1', Colors.deepPurple),
                                  _item('Page2', Colors.green),
                                  _item('Page3', Colors.red),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              // FractionallySizedBox：用来约束它里面的布局在水平或者垂直方向的伸展
                              // 可以控制子布局相对屏幕撑多大，具体比例通过widthFactor控制
                              FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.greenAccent),
                                  child: Text('宽度撑满'),
                                ),
                              )
                            ],
                          ),
                          // Stack：相当于Android的FrameLayout，里面的布局一个叠一个
                          Stack(
                            children: <Widget>[
                              Image.network(
                                'https://www.devio.org/img/avatar.png',
                                width: 100,
                                height: 100,
                              ),
                              // Positioned：绝对布局，要写明相对于父控件的位置
                              Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Image.network(
                                    'https://www.devio.org/img/avatar.png',
                                    width: 36,
                                    height: 36,
                                  ))
                            ],
                          ),
                          Wrap(
                            // 创建一个Wrap布局，从左到右进行排列，会自动换行
                            spacing: 8,
                            runSpacing: 6,
                            children: <Widget>[
                              _chip('Flutter'),
                              _chip('进阶'),
                              _chip('实战'),
                              _chip('携程'),
                              _chip('App'),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onRefresh: _handleRefresh)
            : Column(
                children: <Widget>[
                  Text('列表'),
                  // Expanded：控制容器在父容器中所能撑的大小
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(color: Colors.red.shade900),
                    child: Text('拉伸填满高度'),
                  ))
                ],
              ),
      ),
    );
  }

  ///异步编程
  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    return null;
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(1),
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
