import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/package_type.dart';
import '../../models/city.dart';


class PackageTypeApi {

  final CollectionReference packageTypeCollection =
  FirebaseFirestore.instance.collection('PackageType');

  //add new data
  Future addData({required PackageType add}) async {
    var ref = packageTypeCollection.doc();
    add.id = ref.id;
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required PackageType update}) async {
    return await packageTypeCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required PackageType delete}) async {
    return await packageTypeCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<PackageType>> get getLiveData {
    return packageTypeCollection.snapshots().map(PackageType().fromQuery);
  }



}

