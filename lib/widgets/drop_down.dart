import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class DropDownBuilder extends StatelessWidget {
  final String hint;
  final dynamic selectedItem;
  final Function(dynamic) onChange;
  final bool enabled;

  final List<dynamic> list;
  final String errorText;

  const DropDownBuilder(
      {required this.hint,
      required this.errorText,
      required this.onChange,
      required this.list,
      this.enabled = true,
      Key? key,
      this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<dynamic>(
      name: hint,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: xColors.mainColor, fontSize: 16),
        hintStyle: const TextStyle(color: xColors.hintColor, fontSize: 16),
        contentPadding: EdgeInsets.symmetric(
            vertical: Responsive.height(2.5, context),
            horizontal: Responsive.width(2.0, context)),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: xColors.mainColor),
        ),
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: xColors.mainColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.redAccent),
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
      ),
      // initialValue: 'Male',
      allowClear: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      dropdownColor: Colors.white,
      focusColor: Colors.transparent,
      menuMaxHeight: 200,
      initialValue: selectedItem,
      hint: Text(
        selectedItem != null
            ? '${selectedItem!.name!}'
            : 'Choose $hint',
        style: const TextStyle(color: Colors.black87),
      ),
      validator: (value) {
        if (errorText.isNotEmpty && value == null) {
          return "× $errorText";
        }
        return null;
      },
      onChanged: enabled ? onChange : null,
      items: List<DropdownMenuItem>.from(list.map(
              (s) {return DropdownMenuItem(value: s, child: Text(s.name));
          })),
    );
  }
}
