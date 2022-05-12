import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';
class WidgetToImage extends StatefulWidget {
  final Function(GlobalKey key) builder;

  const WidgetToImage({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _WidgetToImageState createState() => _WidgetToImageState();
}

class _WidgetToImageState extends State<WidgetToImage> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: widget.builder(globalKey),
    );
  }
}

class Utils {
  static Future _capture(GlobalKey key) async {
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  Future<String> createFolder(String cow) async {
    final folderName = cow;
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }


  static Future print({required GlobalKey key,required BuildContext context , required String id}) async {
    final bytes1 = await _capture(key);
    if (await Permission.storage.request().isGranted) {
      await File('/storage/emulated/0/Download/$id.png').writeAsBytes(bytes1).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Saved at Downloads",
          ),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'ok',
            onPressed: () {},
          ),
        ));
      });
    } else {
      await [
        Permission.storage,
      ].request().then((value) async{
        if (await Permission.storage.request().isGranted){
          await File('/storage/emulated/0/Download/$id.png').writeAsBytes(bytes1).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                "Saved at Downloads",
              ),
              action: SnackBarAction(
                textColor: Colors.white,
                label: 'ok',
                onPressed: () {},
              ),
            ));
          });
        }
      });
    }
  }

}

