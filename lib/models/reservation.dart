import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {


  String? id;
  String? packageId;
  String? userId;
  int? capacity;
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
    this.flightTypeId,
    this.hotelId,
    this.roomsAndCount,
    this.packagePrice,
    this.flightPrice,
    this.hotelPrice,
    this.totalPrice,
  });
}
