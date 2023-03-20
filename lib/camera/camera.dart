import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SelectImage extends StatefulWidget {
  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? image;
  Future PickImage()async{
    final img =await ImagePicker().pickImage(source: ImageSource.camera);
    if (img==null)return;
    final temp = File(img.path);
    setState(() {
      image=temp;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Spacer(),
            if(image!=null)Image.file(image!)
      else Image(image: AssetImage('assets/pic/flutter-248.png')),
            SizedBox(
              height: 48,
            ),
            Text(
              'Image Picker',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {PickImage();},
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Take a Picture'),
                  ],
                )),
            SizedBox(
              height: 124,
            ),
          ],
        ),
      ),
    );
  }
}
