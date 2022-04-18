import 'package:flutter/material.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/views/user/reservation/pages/1st_info.dart';
import 'package:reservation_mobile/views/user/reservation/pages/2nd_count.dart';
import 'package:reservation_mobile/views/user/reservation/pages/3rd_hotel.dart';
import 'package:reservation_mobile/views/user/reservation/pages/4th_room.dart';
import 'package:reservation_mobile/views/user/reservation/pages/5th_airline.dart';
import 'package:reservation_mobile/views/user/reservation/pages/7th_summary.dart';
import 'package:reservation_mobile/views/user/reservation/pages/8th_payment.dart';
import 'package:reservation_mobile/views/user/reservation/pages/9th_finish.dart';
import '../views/user/reservation/pages/6th_flight_type.dart';

class ReservationManage extends ChangeNotifier {
  int pageState = 1;
  int maxCount = 0;

  Reservation reservation = Reservation();
  Package package = Package();
  ReservationManage(this.reservation);

  void updateMaxCount(int data) {
    maxCount = data;
    notifyListeners();
  }

  void updateDate(int departAt,int returnAt) {
  reservation.departAt = departAt;
  reservation.returnAt = returnAt;

  notifyListeners();
  }

  void updateCount(int data) {
    reservation.capacity = data;

    reservation.packagePrice = reservation.packagePrice! * data;
    notifyListeners();
  }

  void updateHotel(String data) {
    reservation.hotelId = data;
    reservation.flightPrice;
    reservation.hotelPrice;
    notifyListeners();
  }

  void updateAirline(String data) {
    reservation.airLineId = data;
    notifyListeners();
  }

  void updateFlightType(String data, double price) {
    reservation.flightTypeId = data;

    reservation.flightPrice = price * reservation.capacity!;
    notifyListeners();
  }

  void resetRooms() {
    reservation.roomsAndCount = {};
    reservation.hotelPrice = 0;
    notifyListeners();
  }

  void updateRoomsAndCount(String room, int count, double price) {
    if (reservation.roomsAndCount!.isNotEmpty &&
        reservation.roomsAndCount!.containsKey(room)) {
      //if the value already exist

      if (count == 0) {
        //if the user try to remove the room
        reservation.roomsAndCount!.removeWhere((key, value) => key == room);
      } else {
        //if the user try to increase or decrease the room count
        reservation.roomsAndCount!
            .update(room, (existingValue) => count, ifAbsent: () => count);
      }
    } else {
      //selecting new room
      reservation.roomsAndCount![room] = count;
    }

    //reset the old price
    reservation.hotelPrice = 0;
    //loop inside the rooms map and get the new price
    for (int num in reservation.roomsAndCount!.values) {
      reservation.hotelPrice = reservation.hotelPrice! + (num * price);
    }
    notifyListeners();
  }


  void updateTotalPrice() {
    reservation.totalPrice = reservation.hotelPrice! + reservation.flightPrice! + reservation.packagePrice!;

    print( reservation.totalPrice);
    notifyListeners();
  }

  void onBackPressed() {
    if (pageState > 1 && pageState!=9) {
      pageState = pageState - 1;
      notifyListeners();
    }else if(pageState==9){
      NavigationService.userInstance.pushReplacement('user_home');
    } else {
      NavigationService.userInstance.goBack();
    }
  }

  void goTo(int page) {
    pageState = page;
    notifyListeners();
  }

  Widget currentWidget() {
    switch (pageState) {
      case 1:
        return const ResInfo();
      case 2:
        return const ResCount();
      case 3:
        return const ResHotel();
      case 4:
        return const ResRoom();
      case 5:
        return const ResAirLine();
      case 6:
        return const ResFlightType();
      case 7:
        return const ResSummary();
      case 8:
        return  ResPayment();
      case 9:
        return const ResFinish();
      default:
        return const SizedBox();
    }
  }

  String currentTitle() {
    switch (pageState) {
      case 1:
        return 'Info';
      case 2:
        return 'Count';
      case 3:
        return 'Hotel';
      case 4:
        return "Room";
      case 5:
        return 'AirLine';
      case 6:
        return "Flight Type";
      case 7:
        return "Summary";
      case 8:
        return "Payment";
      case 9:
        return '';
      default:
        return '';
    }
  }
}
