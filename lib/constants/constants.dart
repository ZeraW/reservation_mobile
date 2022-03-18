import 'package:flutter/material.dart';

const Color mainBColor = Colors.blue;
const Color mainGColor = Colors.green;
const Color mainRColor = Colors.red;

const Color whiteFontColor = Colors.white;
const Color blackFontColor = Colors.black;
const Color redFontColor = Colors.red;
final Color greyFontColor = Colors.grey.withOpacity(0.4);

const double fontSize15 = 15.0;
const double fontSize17 = 17.0;
const double fontSize25 = 25.0;

const double iconSize20 = 20.0;
const double iconSize25 = 25.0;

const FontWeight fontWeight400 = FontWeight.w400;
const FontWeight fontWeight600 = FontWeight.w600;
const FontWeight fontWeightBold = FontWeight.bold;

const Color backgroundWhite = Colors.white;
final Color backgroundGrey = Colors.grey.withOpacity(0.3);
const Color colorRed = Colors.red;

const Color whiteIconColor = Colors.white;
const Color blackIconColor = Colors.black;

const double buttonHeight = 55;

List<String> statusList = ['Pending','Finished'];

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          backgroundColor: Colors.grey,
          children: <Widget>[
            Center(
              child: Column(
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'pleaseWait',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

void showMessageDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          backgroundColor: Colors.grey,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.warning_amber_outlined,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                              color: Colors.white, fontSize: fontSize17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}