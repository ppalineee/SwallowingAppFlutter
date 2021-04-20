import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/video_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';
import 'package:swallowing_app/widgets/video_widget.dart';

class VideoPlaylistScreen extends StatefulWidget {
  @override
  _VideoPlaylistScreenState createState() => _VideoPlaylistScreenState();
}

class _VideoPlaylistScreenState extends State<VideoPlaylistScreen> {
  VideoStore _videoStore;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _videoStore = Provider.of<VideoStore>(context);

    if (!_videoStore.loading) {
      await _videoStore.getVideoList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'รายการวิดีโอ', visibilityBackIcon: false),
      body: _buildBody(),
      bottomNavigationBar: Navbar(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: !_videoStore.loading && _videoStore.success,
              child: _buildMainContent(),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _videoStore.loading || !_videoStore.success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: (_videoStore.videoList != null && _videoStore.videoList.videos.length > 0)
            ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _videoStore.videoList.videos.length,
              itemBuilder: (context, index) {
                int i = _videoStore.videoList.videos.length - index - 1;
                return VideoWidget(video: _videoStore.videoList.videos[i]);
              },
            )
            : _handleNoVideosFound()
          ),
        ],
      )
    );
  }

  Widget _handleNoVideosFound() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
              child: Icon(
                Icons.inbox,
                size: 50,
                color: Colors.black45,
              )
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'ไม่พบวิดีโอที่คุณกำลังค้นหา...',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 20),
            ),
          )
        ]
    );
  }
}