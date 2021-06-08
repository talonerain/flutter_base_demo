import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 如何打开第三方应用
class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
              title: Text('如何打开第三方应用'),
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios),
              )),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () => _launchURL(),
                  child: Text('打开浏览器'),
                ),
                RaisedButton(
                  onPressed: () => _openMap(),
                  child: Text('打开地图'),
                )
              ],
            ),
          )),
    );
  }

  _launchURL() async {
    const url = 'https://www.baidu.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openMap() async {
    // android打开方式
    const url = 'geo:52.32,4.917';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Android无法打开，有可能是ios，或者打开失败，尝试用ios打开
      const url = 'http://maps.apple.com/?ll=52.32,4.917';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not Launch & url';
      }
    }
  }
}
