import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';

class ButtonWidget extends StatefulWidget {
  final Widget title;
  final double? width;
  final Color? color;
  final bool? isExpanded;
  final VoidCallback? fun;
  final double? left;
  final double? right;
  const ButtonWidget(this.title,
      {Key? key, this.fun,this.width, this.color, this.isExpanded, this.left, this.right}) : super(key: key);
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  Widget getContent() {
    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: (widget.color ?? mainBColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
      ),
      child: widget.title,
      onPressed: widget.fun,
    );

    Widget container = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          color: (widget.color ?? mainBColor),
        ),
        height: buttonHeight,
        width: widget.width,
        child: button);

    Widget row = Row(
      children: [
        container,
      ],
    );

    if (widget.isExpanded != null) {
      if (widget.isExpanded == true) {
        row = Row(
          children: [
            Expanded(child: container),
          ],
        );
      }
    }

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return getContent();
  }
}
