import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';

class ReportModel {
  final String? id;
  Map<String, int>? totalCount; //total - 1st - 2nd
  Map<String, int>? totalProfit; // total - 1st - 2nd

  Map<String, int>? topCountFirst; //<'id trip', count>
  Map<String, int>? topProfitFirst; //<'id trip', price>

  Map<String, int>? topCountSecond; //<'id trip', count>
  Map<String, int>? topProfitSecond; //<'id trip', price>

  ReportModel({this.id, this.totalCount,this.totalProfit,this.topCountFirst,this.topProfitFirst,this.topCountSecond,this.topProfitSecond,});

  List<ReportModel> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ReportModel(
        id: doc.get('id') ?? '',
        totalCount: doc.get('totalCount') != null
            ? sortMap(Map<String, int>.from(doc.get('totalCount')))
            : {},
        totalProfit: doc.get('totalProfit') != null
            ? sortMap(Map<String, int>.from(doc.get('totalProfit')))
            : {},
        topCountFirst: doc.get('topCountFirst') != null
            ? sortMap(Map<String, int>.from(doc.get('topCountFirst')))
            : {},
        topProfitFirst: doc.get('topProfitFirst') != null
            ? sortMap(Map<String, int>.from(doc.get('topProfitFirst')))
            : {},
        topCountSecond: doc.get('topCountSecond') != null
            ? sortMap(Map<String, int>.from(doc.get('topCountSecond')))
            : {},
        topProfitSecond: doc.get('topProfitSecond') != null
            ? sortMap(Map<String, int>.from(doc.get('topProfitSecond')))
            : {},

      );
    }).toList();
  }


  Map<String, int> sortMap(Map<String, int> map){
    var sortedKeys = map.keys.toList(growable:false)..sort((k2, k1) => map[k1]!.compareTo(map[k2]!));
    LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys, key: (k) => k, value: (k) => map[k]);

    return sortedMap.cast();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['totalCount'] = totalCount;
    data['totalProfit'] = totalProfit;
    data['topCountFirst'] = topCountFirst;
    data['topProfitFirst'] = topProfitFirst;
    data['topCountSecond'] = topCountSecond;
    data['topProfitSecond'] = topProfitSecond;
    return data;
  }
}