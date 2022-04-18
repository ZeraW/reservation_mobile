import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/package_info.dart';

import '../database_api.dart';


class PackageInfoApi {
  final CollectionReference packageInfoCollection =
  FirebaseFirestore.instance.collection('PackageInfo');

  //add new data
  Future addData({required PackageInfo add,File? file}) async {
    var ref = packageInfoCollection.doc();
    add.id = ref.id;
    if(file!=null){
      add.image = await (DatabaseService()
          .uploadImageToStorage(id: 'PackageInfo/${ref.id}', file: file));
    }
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required PackageInfo update,File? file}) async {

    if(file!=null){
      update.image = await (DatabaseService()
          .uploadImageToStorage(id: 'PackageInfo/${update.id}', file: file));
    }
    return await packageInfoCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required PackageInfo delete}) async {
    return await packageInfoCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<PackageInfo>> get getLiveData {
    return packageInfoCollection.snapshots().map(PackageInfo().fromQuery);
  }


// stream for live data
  Stream<List<PackageInfo>>  queryByType(String type) {
    return packageInfoCollection.where('packageTypeId',isEqualTo: type).snapshots().map(PackageInfo().fromQuery);
  }
}

