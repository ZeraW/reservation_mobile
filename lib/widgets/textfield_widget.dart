import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';


class TextFormBuilder extends StatefulWidget {
  final String hint;
  final TextInputType? keyType;
  final bool? isPassword,enabled;
  final TextEditingController controller;
  final int? maxLength,maxLines;
  final Color? activeBorderColor;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChange;

  const TextFormBuilder(
      {required this.hint,
      this.keyType,
      this.isPassword,
        required this.controller,
        this.focusNode,
        this.onSubmitted,
        this.validator,this.onChange,
        this.maxLines=1,
        this.maxLength,
        this.enabled =true,
      this.activeBorderColor,Key? key}) : super(key: key);

  @override
  _TextFormBuilderState createState() => _TextFormBuilderState();
}
class _TextFormBuilderState extends State<TextFormBuilder> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
        name: widget.hint,
        maxLength: widget.maxLength,
        controller: widget.controller,
        style: const TextStyle(fontSize: 16),
        validator: widget.validator,
        enabled: widget.enabled!,
        maxLines: widget.maxLines,
        onChanged: widget.onChange,
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.next,
        keyboardType: widget.keyType ?? TextInputType.text,
        obscureText: widget.isPassword ?? false,
        decoration: InputDecoration(
          labelText: widget.hint,
          labelStyle: TextStyle(
              color: widget.activeBorderColor ?? xColors.mainColor,
              fontSize: 16),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: widget.activeBorderColor ?? xColors.hintColor,
              fontSize: 16),
          contentPadding: EdgeInsets.symmetric(
              vertical: Responsive.height(2.5,context),
              horizontal: Responsive.width(2.0,context)),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: xColors.mainColor),
          ),
          errorStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: widget.activeBorderColor ?? xColors.mainColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.redAccent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Colors.black54, style: BorderStyle.solid),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Colors.black54, style: BorderStyle.solid),
          ),
          fillColor: Colors.white,
        ));
  }
}
