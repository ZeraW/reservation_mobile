import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/provider/search_provider.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';
import 'package:reservation_mobile/views/user/package_result.dart';

import 'reservation/reservation_screen.dart';

class SearchResult extends StatelessWidget {


  const SearchResult({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchManage>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Package',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: ResultList(
        pList: provider.pList,
      ),
    );
  }
}
