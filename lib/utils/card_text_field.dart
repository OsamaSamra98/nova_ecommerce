import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColors.dart';

class CardTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int? length;
  final Widget? prefix;
  final Widget? suffix;
  final TextAlign textAlign;
  final bool isPassword;
  final String? errorMsg;
  final TextInputType textInputType;
  void Function(String value) onChange;
  void Function() onTap;
  final String hint;
  final bool enabled;

  CardTextField(

      {required this.controller,
      required this.label,
      this.prefix,
      this.suffix,
      this.length,
      this.textAlign = TextAlign.start,
      this.enabled = true,
      this.isPassword = false,
      this.errorMsg,
      this.textInputType = TextInputType.text,
      required this.onTap,
      required this.onChange,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: textAlign,
      obscureText: isPassword,
      keyboardType: textInputType,
      maxLength: length,
      enabled: enabled ,
      onTap: () {
        onTap();
      },
      onChanged: (value) {
        onChange(value);
      },
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorMsg,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffix,
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
        enabledBorder: createBorder(color: Colors.grey.shade300),
        border: createBorder(color: AppColors.Orange_COLOR),
        focusedBorder: createBorder(color: AppColors.Orange_COLOR),
        errorBorder: createBorder(color: Colors.red),
        focusedErrorBorder: createBorder(color: Colors.red),
        prefixIcon: getPrefixIcon(),
        labelStyle: TextStyle(
          fontFamily: 'sf',
          fontWeight: FontWeight.normal,
          color: Color(0xFFBFC3DB),
          fontSize: 14,
        ),
      ),
      style: TextStyle(
        fontFamily: 'sf',
        fontWeight: FontWeight.normal,
        color: AppColors.Orange_COLOR,
        fontSize: 16,
      ),
    );
  }

  OutlineInputBorder createBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  dynamic getPrefixIcon() {
    return prefix != null
        ? Padding(
            padding: EdgeInsetsDirectional.only(
              start: 15,
              top: 13,
            ),
            child: prefix,
          )
        : null;
  }
}
