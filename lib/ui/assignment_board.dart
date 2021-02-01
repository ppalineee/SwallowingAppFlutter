import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/post_widget.dart';

class AssignmentBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('กระดานแบบฝึกหัด', true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Stack(
      children: <Widget>[
        // _handleErrorMessage(),
        _buildMainContent(context),
      ],
    );
  }

  Widget _buildMainContent(context) {
    return Stack(
        children: <Widget>[
          Container(
            color: AppColors.lightgray,
            width: MediaQuery.of(context).size.width,
          ),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Post();
            }
          )
        ]
    );
  }
}