import 'package:flutter/material.dart';
import 'package:reservation_mobile/models/package.dart';

class SearchManage extends ChangeNotifier {
  DateTime date;
  RangeValues priceRange;
  List<Package> pList;

  SearchManage({required this.date, required this.priceRange ,required this.pList});
}
