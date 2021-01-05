import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';

class AssignmentStatusTextWidget extends StatelessWidget {
  final int status;
  final double fontSize;

  const AssignmentStatusTextWidget({
    Key key,
    this.status,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getStatusText(status),
      style: TextStyle(
        color: getTextColor(status),
        fontFamily: FontFamily.kanit,
        fontWeight: FontWeight.w600,
        fontSize: this.fontSize
      ),
    );
  }

  String getStatusText(status) {
    if (status == 0) return 'ยังไม่ส่ง';
    if (status == 1) return 'ส่งแล้ว';
    if (status == 2) return 'ผ่าน';
    if (status == 3) return 'ไม่ผ่าน';
    return null;
  }

  Color getTextColor(status) {
    if (status == 0) return AppColors.black;
    if (status == 1) return AppColors.deepblue;
    if (status == 2) return AppColors.green;
    if (status == 3) return AppColors.red;
  }

}

class AssignmentStatusIconWidget extends StatelessWidget {
  final int status;

  const AssignmentStatusIconWidget({
    Key key,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 2)
      return Icon(
        Icons.check_circle,
        color: AppColors.green,
        size: 30,
      );
    if (status == 3)
      return Icon(
        Icons.cancel,
        color: AppColors.red,
        size: 30,
      );
    return SizedBox.shrink();
  }
}