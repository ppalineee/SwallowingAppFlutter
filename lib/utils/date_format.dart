class DateFormats {
  DateFormats._();

  static String changeThaiFullFormat(String date) {
    int year;
    int monthNo;
    String month;
    int day;

    try {
      year = int.parse(date.substring(0,4)) + 543;
      monthNo = int.parse(date.substring(5,7));
      if (monthNo == 1) month = 'มกราคม';
      else if (monthNo == 2) month = 'กุมภาพันธ์';
      else if (monthNo == 3) month = 'มีนาคม';
      else if (monthNo == 4) month = 'เมษายน';
      else if (monthNo == 5) month = 'พฤษภาคม';
      else if (monthNo == 6) month = 'มิถุนายน';
      else if (monthNo == 7) month = 'กรกฎาคม';
      else if (monthNo == 8) month = 'สิงหาคม';
      else if (monthNo == 9) month = 'กันยายน';
      else if (monthNo == 10) month = 'ตุลาคม';
      else if (monthNo == 11) month = 'พฤศจิกายน';
      else if (monthNo == 12) month = 'ธันวาคม';
      day = int.parse(date.substring(8,10));
      return '$day $month $year';
    } catch (e) {
      return '';
    }
  }

  static String changeThaiShortFormat(String date) {
    String year;
    int monthNo;
    String month;
    int day;
    String hour;
    String minute;

    try {
      year = (int.parse(date.substring(0,4)) + 543).toString().substring(2,);
      monthNo = int.parse(date.substring(5,7));
      if (monthNo == 1) month = 'ม.ค';
      else if (monthNo == 2) month = 'ก.พ.';
      else if (monthNo == 3) month = 'มี.ค.';
      else if (monthNo == 4) month = 'เม.ย.';
      else if (monthNo == 5) month = 'พ.ค.';
      else if (monthNo == 6) month = 'มิ.ย.';
      else if (monthNo == 7) month = 'ก.ค.';
      else if (monthNo == 8) month = 'ส.ค.';
      else if (monthNo == 9) month = 'ก.ย.';
      else if (monthNo == 10) month = 'ต.ค.';
      else if (monthNo == 11) month = 'พ.ย.';
      else if (monthNo == 12) month = 'ธ.ค.';
      day = int.parse(date.substring(8,10));
      hour = date.substring(11,13);
      minute = date.substring(14,16);
      return '$day $month $year  $hour:$minute น.';
    } catch (e) {
      return '';
    }
  }
}