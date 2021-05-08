import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/models/thumbnail.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/home_store.dart';
import 'package:swallowing_app/ui/exercise.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';
import 'package:swallowing_app/widgets/thumbnail_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'article.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeStore _homeStore;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _homeStore = Provider.of<HomeStore>(context);

    if (!_homeStore.video_loading) {
      await _homeStore.getVideoList();
    }
    if (!_homeStore.article_loading) {
      await _homeStore.getArticleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'หน้าหลัก', visibilityBackIcon: false),
      body: _buildBody(),
      bottomNavigationBar: Navbar(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Observer(
          builder: (context) {
            return Visibility(
              visible: !_homeStore.video_loading && _homeStore.video_success && !_homeStore.article_loading && _homeStore.article_success,
              child: _buildMainContent(),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _homeStore.video_loading || !_homeStore.video_success || _homeStore.article_loading || !_homeStore.article_success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              _buildVideoListHeader(),
              SizedBox(
                height: 10,
              ),
              _buildVideoList(),
              SizedBox(
                height: 15,
              ),
            ],
        ),
        Divider(
          thickness: 1.5,
          color: AppColors.lightgray,
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _buildArticleListHeader(),
            SizedBox(
              height: 10,
            ),
            _buildArticleList(),
          ],
        ),
        SizedBox(
          height: 15,
        )
      ]
    );
  }

  Widget _buildVideoListHeader() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              'วิดีโอแนะนำ',
              style: TextStyle(
                fontFamily: FontFamily.kanit,
                fontSize: 26,
                color: AppColors.deepblue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.video_playlist);
              Navbar.selectedIndex = 1;
            },
            child: Text(
              'ดูทั้งหมด >',
              style: TextStyle(
                fontFamily: FontFamily.kanit,
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoList() {
    return Container(
        height: 160,
        child: (_homeStore.videoList != null && _homeStore.videoList.videos.length > 0)
            ? ListView.separated(
          padding: EdgeInsets.only(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          itemCount: (_homeStore.videoList.videos.length) < 6
              ? _homeStore.videoList.videos.length : 6,
          itemBuilder: (context, index) {
            int i = _homeStore.videoList.videos.length - index - 1;
            Video video = _homeStore.videoList.videos[i];
            return HomeVideoWidget(video: video);
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 5);
          },
        )
            : _handleNoVideosFound()
    );
  }

  Widget _buildArticleListHeader() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              'บทความ',
              style: TextStyle(
                fontFamily: FontFamily.kanit,
                fontSize: 26,
                color: AppColors.deepblue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pushReplacementNamed(Routes.article_list);
              await SharedPreferences.getInstance().then((preference) {
                if (preference.getString(Preferences.role) == 'Patient') {
                  Navbar.selectedIndex = 3;
                } else {
                  Navbar.selectedIndex = 2;
                }
              });
            },
            child: Text(
              'ดูทั้งหมด >',
              style: TextStyle(
                fontFamily: FontFamily.kanit,
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleList() {
    return Container(
      height: 160,
      child: (_homeStore.articleList != null && _homeStore.articleList.articles.length > 0)
      ? ListView.separated(
          padding: EdgeInsets.only(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          itemCount: (_homeStore.articleList.articles.length) < 6
              ? _homeStore.articleList.articles.length : 6,
          itemBuilder: (context, index) {
            int i = _homeStore.articleList.articles.length - index - 1;
            Article article = _homeStore.articleList.articles[i];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ArticleScreen(article: article)
                    )
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 1,
                child: ClipPath(
                  child: Column(
                      children: <Widget>[
                        Container(
                          width: 190,
                          height: 190 * Dimens.video_height / Dimens.video_width,
                          color: AppColors.gray,
                          child: Image.network(
                            article.imgUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              return Center(
                                  child: Icon(
                                    Icons.no_photography_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  )
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 40,
                          child: Center(
                            child: Text(
                              article.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: FontFamily.kanit,
                                fontSize: 15,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                  ),
                ),
              )
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 5);
          },
        )
        : _handleNoArticlesFound()
    );
  }

  Widget _handleNoVideosFound() {
    return Center(
      child: Text(
        'ไม่พบวิดีโอที่คุณกำลังค้นหา...',
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 17),
      ),
    );
  }

  Widget _handleNoArticlesFound() {
    return Center(
      child: Text(
        'ไม่พบบทความที่คุณกำลังค้นหา...',
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 17),
      ),
    );
  }
}

class HomeVideoWidget extends StatefulWidget {
  final Video video;

  HomeVideoWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _HomeVideoWidgetState createState() => _HomeVideoWidgetState();
}

class _HomeVideoWidgetState extends State<HomeVideoWidget> {
  GenThumbnailImage _futureImage;
  String _tempDir;

  @override
  void initState() {
    super.initState();
    getTemporaryDirectory().then((d) => _tempDir = d.path);
    _futureImage = GenThumbnailImage(
        thumbnailRequest: ThumbnailRequest(
            video: widget.video.url,
            thumbnailPath: _tempDir,
            imageFormat: ImageFormat.JPEG,
            maxHeight: 0,
            maxWidth: 0,
            timeMs: 100,
            quality: 100),
        parentWidget: 'VideoWidget'
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ExerciseScreen(video: widget.video)
              )
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
          child: ClipPath(
            child: Column(
                children: <Widget>[
                  Container(
                      width: 190,
                      height: 190 * Dimens.video_height / Dimens.video_width,
                      color: AppColors.gray,
                      child: (_futureImage != null) ? _futureImage : SizedBox()
                  ),
                  Container(
                    width: 160,
                    height: 40,
                    child: Center(
                      child: Text(
                        widget.video.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FontFamily.kanit,
                          fontSize: 15,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
              ),
            ),
          ),
        )
    );
  }
}
