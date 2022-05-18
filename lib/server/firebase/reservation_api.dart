import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';
import 'package:reservation_mobile/server/firebase/report_api.dart';


class ReservationApi {

  final CollectionReference reservationCollection =
  FirebaseFirestore.instance.collection('Reservation');


  //add new data
  Future addData({required Reservation add}) async {
    var ref = reservationCollection.doc();
    add.id = ref.id;
    return await ref.set(add.toJson()).then((value) async{
      await  ReportApi().updateBookingStats(add);
    });
  }

  //update existing data
  Future updateData({required Reservation update}) async {
    return await reservationCollection
        .doc(update.id.toString())
        .update(update.toJson());
  }

  //delete existing data
  Future deleteData({required Reservation delete}) async {
    delete.canceled = true;
    return await reservationCollection.doc(delete.id.toString())
        .update(delete.toJson()).then((value)async{

      PackageApi().packageCollection.doc(delete.packageId).update({
        'remaining':FieldValue.increment(delete.capacity!)
      });
    });
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

