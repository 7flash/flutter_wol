import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wol/widgets/main_text_field.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final controller = TextEditingController();
  File _image;

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
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
        child: Column(
          children: <Widget>[
            MainTextField(
              labelText: "Activity Title",
              controller: controller,
            ),
            SizedBox(height: 7),
            _image != null ? Image.file(_image) : Container(),
          ],
        ),
      ),
    );
  }

  Future _getImageFromCamera() async {
    print("get image from camera");
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print("done1");
    setState(() {
      _image = image;
    });
    print("done2");
    // Navigator.of(context).maybePop();
  }

  // void _saveProfile(ProfileModel profile) async {
  //   savingLoader.currentState.loading();
  //   var attachmentUrl;
  //   if(_profileImage != null) {
  //     attachmentUrl = await _uploadFile(profile);
  //   }
  //   await Provider.of<EosService>(context, listen: false).updateProfile(
  //     nickname: _nameController.text ?? (profile.nickname ?? ''),
  //     image: attachmentUrl ?? (profile.image ?? ''),
  //     story: '',
  //     roles: '',
  //     skills:'',
  //     interests: '',
  //   );
  //   savingLoader.currentState.done();
  // }

  // _uploadFile(ProfileModel profile) async {
  //   String extensionName = pathUtils.extension(_profileImage.path);
  //   String path = "ProfileImage/" +
  //       profile.account +
  //       '/' +
  //       Uuid().v4() +
  //       extensionName;
  //   StorageReference storageReference =
  //   FirebaseStorage.instance.ref().child(path);
  //   String fileType =
  //   extensionName.isNotEmpty ? extensionName.substring(1) : '*';
  //   var uploadTask = storageReference.putFile(
  //       _profileImage, StorageMetadata(contentType: "image/$fileType"));
  //   await uploadTask.onComplete;
  //   return await storageReference.getDownloadURL();
  // }
}
