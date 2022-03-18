import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/reservation.dart';
import '../../models/city.dart';


class ReservationApi {

  final CollectionReference reservationCollection =
  FirebaseFirestore.instance.collection('Reservation');


  //add new data
  Future addReservation({required Reservation add}) async {
    var ref = reservationCollection.doc(add.id.toString());
    return await ref.set(add.toJson());
  }

  //update existing data
  Future updateReservation({required Reservation update}) async {
    return await reservationCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteReservation({required Reservation delete}) async {
    return await reservationCollection.doc(delete.id.toString()).delete();
  }

  // stream for live data
  Stream<List<Reservation>> get getLiveCities {
    return reservationCollection.snapshots().map((event) {
      return event.docs.map((e) => Reservation.fromJson(e)).toList();
    },);
  }



}

