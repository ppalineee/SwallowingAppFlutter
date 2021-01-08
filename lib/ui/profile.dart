import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/profile_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileStore _profileStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);

    if (!_profileStore.loading) {
      _profileStore.getPatientProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('ประวัติของฉัน', true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildMainContent(),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _profileStore.loading || !_profileStore.success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
        ),
        Center(
          child: Container(
            height: 390,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.fromLTRB(20, 75, 20, 20),
                    width: MediaQuery.of(context).size.width-80,
                    height: 390,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Observer(
                      builder: (context) {
                        return Visibility(
                          visible: _profileStore.success,
                          child: _fetchProfileData()
                        );
                      },
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.account_circle,
                      color: AppColors.gray,
                      size: 100,
                    ),
                  ),
                )
              ],
            ),
          )
        )
      ]
    );
  }

  Widget _fetchProfileData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                'HN',
                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
            _space(),
            Text(
                'ชื่อ',
                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
            _space(),
            Text(
                'นามสกุล',
                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
            _space(),
            Text(
                'เพศ',
                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
            _space(),
            Text(
                'วันเกิด',
                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
            _space(),
            Text(
                'ผู้ดูแล',
                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                _profileStore.profile.hnNumber,
                style: TextStyle(fontSize: 17)),
            _space(),
            Text(
                _profileStore.profile.firstName,
                style: TextStyle(fontSize: 17)),
            _space(),
            Text(
                _profileStore.profile.lastName,
                style: TextStyle(fontSize: 17)),
            _space(),
            Text(
                _profileStore.profile.gender,
                style: TextStyle(fontSize: 17)),
            _space(),
            Text(
                _changeDateFormat(_profileStore.profile.birthdate),
                style: TextStyle(fontSize: 17)),
            _space(),
            Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width-200,
                  child: Text(
                      'ผู้ดูแล',
                      style: TextStyle(fontSize: 17)),
                )
            )
          ],
        ),
      ],
    );
  }

  Widget _space() {
    return SizedBox(height: 10);
  }

  String _changeDateFormat(String date) {
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
}