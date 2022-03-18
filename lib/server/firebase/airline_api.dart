import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/airline.dart';

import '../database_api.dart';

class AirlineApi {

  final CollectionReference airLineCollection =
  FirebaseFirestore.instance.collection('AirLine');

  //add new data
  Future addData({required Airline add,File? file}) async {
    var ref = airLineCollection.doc();
    add.id = ref.id;
    if(file!=null){
      add.image = await (DatabaseService()
          .uploadImageToStorage(id: 'AirLine/${ref.id}', file: file));
    }


    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Airline update,File? file}) async {
    if(file!=null){
      update.image = await (DatabaseService()
          .uploadImageToStorage(id: 'AirLine/${update.id}', file: file));
    }
    return await airLineCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Airline delete}) async {
    return await airLineCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Airline>> get getLiveData {
    return airLineCollection.snapshots().map(Airline().fromQuery);
  }



}

