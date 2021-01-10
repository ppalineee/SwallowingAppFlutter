import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/utils/authtoken_util.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('ตั้งค่า', true),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
        ),
        _buildSignOutBtn(context)
      ]
    );
  }
  
  Widget _buildSignOutBtn(context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 50),
      selected: true,
      selectedTileColor: AppColors.white,
      leading: Icon(
        Icons.logout,
        color: Colors.black45,
        size: 25,
      ),
      title: Text(
        'ออกจากระบบ',
        style: TextStyle(fontSize: 17, color: AppColors.black),
      ),
      onTap: () async {
        AuthToken _authToken = Provider.of<AuthToken>(context, listen: false);
        await _authToken.logoutPatient();

        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          print('is_logged_in: ${preference.getBool(Preferences.is_logged_in)}');
          print('auth_token: ${preference.getString(Preferences.auth_token)}');
          print('profile: ${preference.getString(Preferences.patient_profile)}');
        });

        Future.delayed(Duration(milliseconds: 0), () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.login, (Route<dynamic> route) => false);
          Navbar.selectedIndex = 0;
        });
      } ,
    );
  }
}
