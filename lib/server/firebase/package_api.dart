import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/package.dart';

class PackageApi {
  final CollectionReference packageCollection =
      FirebaseFirestore.instance.collection('Packages');

  //add new data
  Future addData({required Package add}) async {
    var ref = packageCollection.doc();
    add.id = ref.id;
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Package update}) async {
    return await packageCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //update existing data
  Future updateCount({required int count,required docId}) async {
    return await packageCollection
        .doc(docId)
        .update({"remaining": FieldValue.increment(count)});
  }

  //delete existing data
  Future deleteData({required Package delete}) async {
    return await packageCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Package>> get getLiveData {
    return packageCollection.snapshots().map(Package().fromQuery);
  }

// stream for live data
  Stream<List<Package>> query(
      {String? pType,
      String? city,
      String? country,
      int? price1,
      int? price2}) {
    return packageCollection
        .where('keyWords.pType', isEqualTo: pType)
        .where('keyWords.country', isEqualTo: country)
        .where('keyWords.city', isEqualTo: city)
        .where('keyWords.price', isGreaterThanOrEqualTo: price1)
        .where('keyWords.price', isLessThanOrEqualTo: price2)
        .snapshots()
        .map(Package().fromQuery);
  }

// stream for live data
  Stream<List<Package>> getPackagesByPackageInfo({
    String? pInfo,
  }) {
    return packageCollection
        .where('packetInfoId', isEqualTo: pInfo)
        .where('keyWords.departAt',
            isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day)
                .millisecondsSinceEpoch)
        .snapshots()
        .map(Package().fromQuery);
  }

  // stream for live data
  Stream<List<Package>> getAllPackagesByPackageInfo({
    String? pInfo,
  }) {
    return packageCollection
        .where('packetInfoId', isEqualTo: pInfo)
        .snapshots()
        .map(Package().fromQuery);
  }

  // stream for live data
  Stream<List<Package>> getPackagesByDate({required bool isUpcoming,}) {
    return isUpcoming ? packageCollection
        .where('keyWords.departAt', isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day)
            .millisecondsSinceEpoch)
        .snapshots()
        .map(Package().fromQuery) : packageCollection
        .where('keyWords.departAt', isLessThan: DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day)
        .millisecondsSinceEpoch)
        .snapshots()
        .map(Package().fromQuery);
  }


}
