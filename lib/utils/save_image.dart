// ignore_for_file: unnecessary_brace_in_string_interps
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/services.dart';

Future<String> saveImage(File? imageFile, String userInfo) async {
  if (imageFile != null) {
    final fileName = 'user_${userInfo}.jpg';
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('userimage/$fileName');
    final UploadTask uploadTask = storageReference.putFile(imageFile);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }
  return '';
}

Future<String> uploadDefaultImage(String userInfo) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  ByteData imageData = await rootBundle.load('assets/images/profile.png');
  Uint8List imageBytes = imageData.buffer.asUint8List();
  Reference storageRef = storage.ref().child('userimage/user_${userInfo}.jpg');
  UploadTask uploadTask = storageRef.putData(imageBytes);
  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}
