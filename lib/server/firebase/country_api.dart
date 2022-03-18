import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/country.dart';

class CountryApi {
  final CollectionReference countriesCollection =
  FirebaseFirestore.instance.collection('Country');

  //add new data
  Future addData({required Country add}) async {
    var ref = countriesCollection.doc();
    add.id = ref.id;

    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Country update}) async {
    return await countriesCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Country delete}) async {
    return await countriesCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Country>> get getLiveData {
    return countriesCollection.snapshots().map(Country().fromQuery);
  }



}

