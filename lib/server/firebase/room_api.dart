import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/room.dart';
import '../database_api.dart';

class RoomApi {
  final CollectionReference roomCollection =
  FirebaseFirestore.instance.collection('Room');

  //add new data
  Future addData({required Room add,File? file}) async {
    var ref = roomCollection.doc();
    add.id = ref.id;
    if(file!=null){
      add.image = await (DatabaseService()
          .uploadImageToStorage(id: 'Room/${ref.id}', file: file));
    }
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Room update,File? file}) async {
    if(file!=null){
      update.image = await (DatabaseService()
          .uploadImageToStorage(id: 'Room/${update.id}', file: file));
    }
    return await roomCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Room delete}) async {
    return await roomCollection.doc(delete.id.toString()).delete();
  }


// stream for live data
  Stream<List<Room>>  getLiveData(String id) {
    return roomCollection.where('hotelId' , isEqualTo:id ).snapshots().map(Room().fromQuery);
  }
// stream for live data
  Stream<List<Room>> get getAllLiveData {
    return roomCollection.snapshots().map(Room().fromQuery);
  }


}

