import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/reservation.dart';


class ReservationApi {

  final CollectionReference reservationCollection =
  FirebaseFirestore.instance.collection('Reservation');


  //add new data
  Future addData({required Reservation add}) async {
    var ref = reservationCollection.doc();
    add.id = ref.id;
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateData({required Reservation update}) async {
    return await reservationCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Reservation delete}) async {
    return await reservationCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Reservation>> get getLiveData {
    return reservationCollection.snapshots().map(Reservation().fromQuery);
  }


  Stream<List<Reservation>> query(
      {String? pId,String? user}) {
    return reservationCollection
        .where('userId', isEqualTo: user)
        .where('packageId', isEqualTo: pId)
        .snapshots()
        .map(Reservation().fromQuery);
  }
}

