import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';
class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  Widget getContent() {
    Widget container = Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Center(
                child: Image.asset('assets/image/holder.jpg',),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
      decoration: const BoxDecoration(
        //border: Border.all(color: Colors.black, width: 1),
        color: backgroundWhite,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 15,
      ),
      child: container,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getContent();
  }
}
