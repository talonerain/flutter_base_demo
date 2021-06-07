import 'package:flutter/material.dart';

///StatefulWidget与基础组件
class StateFulGroup extends StatefulWidget {
  @override
  _StateFulGroupState createState() {
    // TODO: implement createState
    return _StateFulGroupState();
  }
}

class _StateFulGroupState extends State<StateFulGroup> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'StatefulWidget与基础组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("StatefulWidget与基础组件"),
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
                          Text(
                            'I am text',
                            style: textStyle,
                          ),
                          Icon(
                            Icons.android,
                            size: 50,
                            color: Colors.red,
                          ),
                          CloseButton(),
                          BackButton(),
                          Chip(
                            label: Text('StatelessWidget与基础组件'),
                            avatar: Icon(Icons.people),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.orange,
                            indent: 10,
                          ),
                          Card(
                            //带有圆角，阴影，边框等效果的卡片
                            color: Colors.blue,
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'I am card',
                                style: textStyle,
                              ),
                            ),
                          ),
                          AlertDialog(
                            title: Text('盘他'),
                            content: Text('你这个糟老头坏的很'),
                          ),
                          Image.network(
                            'https://www.devio.org/img/avatar.png',
                            width: 100,
                            height: 100,
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
                            margin: EdgeInsets.only(top: 50),
                            decoration:
                                BoxDecoration(color: Colors.lightBlueAccent),
                            child: PageView(
                              children: <Widget>[
                                _item('Page1', Colors.deepPurple),
                                _item('Page2', Colors.green),
                                _item('Page2', Colors.red),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onRefresh: _handleRefresh)
            : Text('列表'),
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
}
