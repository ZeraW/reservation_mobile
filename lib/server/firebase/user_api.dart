import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/user.dart';

class UserApi {
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('Users');

//get my user
  Stream<DocumentSnapshot> get getUserById {
    return userCollection.doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  }


  Stream<UserModel> get getCurrentUser {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()));
  }

Stream<List<UserModel>> get getLiveUsers {
  return userCollection
      .snapshots()
      .map(UserModel().fromQuery);
}

//upload Image method
  Future uploadImageToStorage({required File file, String? id}) async {
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('images/$id.png');

    firebase_storage.UploadTask task = ref.putFile(file);

    // We can still optionally use the Future alongside the stream.
    try {
      //update image
      await task;
      String url = await FirebaseStorage.instance
          .ref('images/$id.png')
          .getDownloadURL();

      return url;
    } on firebase_storage.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
  }

//updateUserData
  Future<void> updateUserData({required UserModel user}) async {
    return await userCollection.doc(user.id).set(user.toJson());
  }

}

