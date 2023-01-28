import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:intern_task/Utils/utils.dart';
import 'package:intern_task/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image; //use File of dart:io not dart:html
  ImagePicker picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance; //to upload the image
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('post');
  bool loading = false;

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80); //max image quality is 100
    setState(
      () {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          Utils().toastMessage('No file selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Upload image')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.pink)),
                child: image != null
                    ? Image.file(image!.absolute)
                    : const Center(child: Icon(Icons.image)),
              ),
            ),
            SizedBox(
              height: 50,
            ),

            RoundButton(
                loading: loading,
                title: 'Upload',
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('${DateTime.now().millisecondsSinceEpoch}' );
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(image!.absolute);
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('uploaded');
                  Future.value(uploadTask).then((value) {
                     var newUrl = ref
                         .getDownloadURL(); //after uploading it will return url
                      databaseRef
                          .child('1')
                          .set({'id': '111', 'title': newUrl.toString()}).then(
                              (value) {
                       setState(() {
                         loading = false;
                       });
                      Utils().toastMessage('uploaded');
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  }); //waiting to get uploaded
                }),
          ],
        ),
      ),
    );
  }
}


