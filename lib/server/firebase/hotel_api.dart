import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/hotel.dart';
import '../database_api.dart';

class HotelApi {
  final CollectionReference hotelsCollection =
  FirebaseFirestore.instance.collection('Hotels');

  //add new data
  Future addData({required Hotel add,File? file}) async {
    var ref = hotelsCollection.doc();
    add.id = ref.id;
    if(file!=null){
      add.image = await (DatabaseService()
          .uploadImageToStorage(id: 'Hotels/${ref.id}', file: file));
    }
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Hotel update,File? file}) async {
    if(file!=null){
      update.image = await (DatabaseService()
          .uploadImageToStorage(id: 'Hotels/${update.id}', file: file));
    }
    return await hotelsCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Hotel delete}) async {
    return await hotelsCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Hotel>> get getLiveData {
  return hotelsCollection.snapshots().map(Hotel().fromQuery);
  }



}

