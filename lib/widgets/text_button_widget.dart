import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';

class TextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final TextStyle textStyle;
  final VoidCallback onPressed;

  const TextButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor = AppColors.deepblue,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: onPressed,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 8.0),
        child: Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
