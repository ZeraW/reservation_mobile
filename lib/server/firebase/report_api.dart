import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_mobile/models/report.dart';
import 'package:intl/intl.dart';
import 'package:reservation_mobile/models/reservation.dart';


class ReportApi {

final CollectionReference reportCollection =
FirebaseFirestore.instance.collection('Report');

Future updateBookingStats(Reservation reservation) async {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(reservation.departAt!);

  String year = '${dateTime.year}';
  int month = dateTime.month;

  var ref = reportCollection.doc(year);
  ref.get().then((value) {
    if (value.exists) {
      if (month <= 6) {
        return ref.update({
          'totalProfit.price': FieldValue.increment(reservation.totalPrice!.toInt()),
          'totalProfit.1st': FieldValue.increment(reservation.totalPrice!.toInt()),
          'totalProfit.$month': FieldValue.increment(reservation.totalPrice!.toInt()),

          'totalCount.1st': FieldValue.increment(1),
          'totalCount.count': FieldValue.increment(1),
          'totalCount.$month': FieldValue.increment(1),


          'topProfitFirst.${reservation.packageId}': FieldValue.increment(reservation.totalPrice!.toInt()),
          'topCountFirst.${reservation.packageId}': FieldValue.increment(1)
        });
      } else {
        return ref.update({
          'totalProfit.price': FieldValue.increment(reservation.totalPrice!.toInt()),
          'totalProfit.$month': FieldValue.increment(reservation.totalPrice!.toInt()),
          'totalProfit.2nd': FieldValue.increment(reservation.totalPrice!.toInt()),

          'totalCount.count': FieldValue.increment(1),
          'totalCount.2nd': FieldValue.increment(1),
          'totalCount.$month': FieldValue.increment(1),

          'topProfitSecond.${reservation.totalPrice!.toInt()}':
          FieldValue.increment(reservation.totalPrice!.toInt()),
          'topCountSecond.${reservation.packageId}': FieldValue.increment(1)
        });
      }
    } else {
      if (month <= 6) {
        ReportModel newReport = ReportModel(
            id: year,
            totalProfit: {'price': reservation.totalPrice!.toInt(), '1st': reservation.totalPrice!.toInt(),'$month': reservation.totalPrice!.toInt(),},
            totalCount: {'1st': 1, 'count': 1,'$month': 1,},
            topProfitFirst: {'${reservation.packageId}': reservation.totalPrice!.toInt()},
            topCountFirst: {'${reservation.packageId}': 1},
            topProfitSecond: {},topCountSecond: {});
        return ref.set(newReport.toJson());
      } else {
        ReportModel newReport = ReportModel(
            id: year,
            totalProfit: {'price': reservation.totalPrice!.toInt(), '2nd': reservation.totalPrice!.toInt(),'$month': reservation.totalPrice!.toInt(),},
            totalCount: {'count': 1,'2nd': 1,'$month': 1,},
            topProfitSecond: {'${reservation.packageId}': reservation.totalPrice!.toInt()},
            topCountSecond: {'${reservation.packageId}': 1},
            topCountFirst: {},topProfitFirst: {});
        return ref.set(newReport.toJson());
      }
    }
  });
}

// stream for reports
Stream<List<ReportModel>> get getLiveReports {
  return reportCollection.snapshots().map(ReportModel().fromQuery);
}


}