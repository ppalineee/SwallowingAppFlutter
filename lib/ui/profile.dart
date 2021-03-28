import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/profile_store.dart';
import 'package:swallowing_app/utils/date_format.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileStore _profileStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);

    if (!_profileStore.loading) {
      await _profileStore.getPatientProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'ประวัติของฉัน', visibilityBackIcon: true),
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
        Container(
          padding: EdgeInsets.only(bottom: 40),
          alignment: Alignment.center,
          child: Container(
            height: 390,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 60),
                      padding: EdgeInsets.fromLTRB(20, 75, 20, 20),
                      width: MediaQuery.of(context).size.width - 80,
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
          ),
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
        Observer(
          builder: (context) {
            return Column(
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
                    DateFormats.changeThaiFullFormat(_profileStore.profile.birthdate),
                    style: TextStyle(fontSize: 17)),
                _space(),
                Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width-200,
                      child: Text(
                          _profileStore.profile.therapist,
                          style: TextStyle(fontSize: 17)),
                    )
                )
              ],
            );
          },
        )
      ],
    );
  }

  Widget _space() {
    return SizedBox(height: 10);
  }
}