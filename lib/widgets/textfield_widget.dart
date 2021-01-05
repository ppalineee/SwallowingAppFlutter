import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/constants/colors.dart';

import '../constants/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final ValueChanged onChanged;
  final bool autoFocus;
  final TextInputAction inputAction;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.inputType,
    this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLines: 1,
        keyboardType: this.inputType,
        style: TextStyle(
          fontFamily: FontFamily.kanit,
          color: AppColors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
            hintText: this.hint,
            hintStyle: TextStyle(
              fontFamily: FontFamily.kanit,
              color: Colors.black45,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            errorText: errorText,
            errorStyle: TextStyle(
              fontFamily: FontFamily.kanit,
              color: AppColors.red,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            counterText: '',
            icon: this.isIcon ? Icon(this.icon, color: iconColor) : null),
      ),
    );
  }

}
