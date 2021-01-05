import 'package:flutter/material.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/video_widget.dart';

class VideoPlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('รายการวิดีโอ', false),
      body: _buildBody(context),
      bottomNavigationBar: Navbar(),
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
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: 6,
              itemBuilder: (context, index) {
                return VideoWidget();
              },
              separatorBuilder: (context, index) {
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      )
    );
  }
}