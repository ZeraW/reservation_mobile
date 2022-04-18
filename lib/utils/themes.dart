import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    backgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
        centerTitle: false,
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        )),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        color: Colors.black,
      ),
    ),
  );
}

