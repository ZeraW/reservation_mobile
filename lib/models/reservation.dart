import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {


  String? id;
  String? packageId;
  String? userId;
  int? capacity;
  int? departAt;
  int? returnAt;
  bool? canceled;

  String? airLineId;
  String? flightTypeId;
  String? hotelId;
  Map<String , int>? roomsAndCount; //room id , count
  double ? packagePrice ;       //( price from package * user capacity )
  double ? flightPrice ;        //( price from flight * user capacity )
  double ? hotelPrice ;          //( rooms price * room count )
  double ? totalPrice ;          //( package_price  + flight_price + hotel_price )



  factory Reservation.fromJson(var json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  Reservation({
    this.id,
    this.packageId,
    this.userId,
    this.capacity,
    this.airLineId,
    this.departAt,this.canceled,
    this.returnAt,
    this.flightTypeId,
    this.hotelId,
    this.roomsAndCount,
    this.packagePrice,
    this.flightPrice,
    this.hotelPrice,
    this.totalPrice,
  });


  List<Reservation> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Reservation(
          id: doc.get('id'),
          packageId: doc.get('packageId'),
          userId: doc.get('userId'),
          capacity: doc.get('capacity'),
          airLineId: doc.get('airLineId'),
          departAt: doc.get('departAt'),
          returnAt: doc.get('returnAt'),
          canceled: doc.get('canceled')??false,
          flightTypeId: doc.get('flightTypeId'),
          hotelId: doc.get('hotelId'),
          packagePrice: doc.get('packagePrice').toDouble(),
          flightPrice: doc.get('flightPrice').toDouble(),
          hotelPrice: doc.get('hotelPrice').toDouble(),
          totalPrice: doc.get('totalPrice').toDouble(),

          roomsAndCount: doc.get('roomsAndCount') != null
              ? Map<String, int>.from(doc.get('roomsAndCount'))
              : {});
    }).toList();
  }
}
