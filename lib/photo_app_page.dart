import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(PhotoApp());
}

/// 【实战尝鲜】拍照APP开发
class PhotoApp extends StatefulWidget {
  @override
  _PhotoAppState createState() => _PhotoAppState();
}

class _PhotoAppState extends State<PhotoApp> {
  // 保存每次选择的图片
  List<File> _images;
  final picker = ImagePicker();

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);

    final pickedFile = await picker.getImage(
        source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
        print('image == ' + _images.toString());
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: getImages(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  _pickImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 160,
              child: Column(
                children: [_item('拍照', true), _item('从相册选择', false)],
              ),
            ));
  }

  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto),
      ),
    );
  }

  getImages() {
    // 遍历已选择的图片
    return _images.map((file) {
      return Stack(
        children: [
          ClipRRect(
            // 圆角效果
            borderRadius: BorderRadius.circular(5),
            child: Image.file(
              file,
              width: 120,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _images.remove(file);
                });
              },
              child: ClipOval(
                  child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.black54),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              )),
            ),
          )
        ],
      );
    }).toList();
  }
}
