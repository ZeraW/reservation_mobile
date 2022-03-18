import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/flight_type.dart';


class FlightTypeApi {
  final CollectionReference flightTypeCollection =
  FirebaseFirestore.instance.collection('FlightType');

  //add new data
  Future addData({required FlightType add}) async {
    var ref = flightTypeCollection.doc();
    add.id = ref.id;
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required FlightType update}) async {
    return await flightTypeCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required FlightType delete}) async {
    return await flightTypeCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<FlightType>> get getLiveData {
    return flightTypeCollection.snapshots().map(FlightType().fromQuery);
  }



}

