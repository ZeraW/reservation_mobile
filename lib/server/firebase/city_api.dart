import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/city.dart';


class CityApi {
  final CollectionReference citiesCollection =
  FirebaseFirestore.instance.collection('Cities');

  //add new data
  Future addData({required City add}) async {
    var ref = citiesCollection.doc();
    add.id = ref.id;

    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required City update}) async {
    return await citiesCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required City delete}) async {
    return await citiesCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<City>>  getLiveData(String id) {
    return citiesCollection.where('countryId' , isEqualTo:id ).snapshots().map(City().fromQuery);
  }
// stream for live data
  Stream<List<City>> get getAllLiveData {
    return citiesCollection.snapshots().map(City().fromQuery);
  }


}

