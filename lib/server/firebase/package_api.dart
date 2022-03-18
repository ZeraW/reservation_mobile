import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/package.dart';

class PackageApi {
  final CollectionReference packageCollection =
  FirebaseFirestore.instance.collection('Packages');

  //add new data
  Future addData({required Package add}) async {
    var ref = packageCollection.doc();
    add.id =ref.id;
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Package update}) async {
    return await packageCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Package delete}) async {
    return await packageCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Package>> get getLiveData {
    return packageCollection.snapshots().map(Package().fromQuery);
  }




}

