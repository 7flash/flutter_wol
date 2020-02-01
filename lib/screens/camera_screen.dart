import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wol/widgets/main_text_field.dart';
import 'package:path/path.dart' as pathUtils;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

import 'package:firebase_storage/firebase_storage.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final titleController = TextEditingController();
  File _image;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getImageFromCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        title: Text("Describe Activity"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: _loading == false
                ? IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      await _publishActivity();
                      setState(() {
                        _loading = false;
                      });
                      Navigator.of(context).maybePop();
                    },
                  )
                : CircularProgressIndicator(),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
        child: Column(
          children: <Widget>[
            MainTextField(
              labelText: "Activity Title",
              controller: titleController,
            ),
            SizedBox(height: 7),
            _image != null ? Image.file(_image) : Container(),
          ],
        ),
      ),
    );
  }

  Future _getImageFromCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    // var resizedImage = img.copyResize(img.decodeImage(imageFile.readAsBytesSync()), height: 250);
    // var resizedFile = File("temp")..writeAsBytesSync(img.encodePng(resizedImage));
    setState(() {
      _image = imageFile;
    });
  }

  Future _publishActivity() async {
    String extensionName = pathUtils.extension(_image.path);
    String path = "activities/${Uuid().v4()}.$extensionName";
    String fileType =
        extensionName.isNotEmpty ? extensionName.substring(1) : '*';

    var ref = FirebaseStorage.instance.ref().child(path);

    var uploadTask = ref.putFile(
      _image,
      StorageMetadata(contentType: "image/$fileType"),
    );

    String imageURL = await (await uploadTask.onComplete).ref.getDownloadURL();

    await Firestore.instance.collection("activities").add({
      "title": titleController.text,
      "image": imageURL,
      "timestamp": Timestamp.now(),
    });
  }
}
