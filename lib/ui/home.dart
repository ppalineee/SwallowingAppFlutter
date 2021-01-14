import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/home_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';

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

    if (!_homeStore.loading) {
      await _homeStore.getArticleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('หน้าหลัก', false),
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
              visible: !_homeStore.loading && _homeStore.success,
              child: _buildMainContent(),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _homeStore.loading || !_homeStore.success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                _buildVideoListHeader(),
                SizedBox(
                  height: 10,
                ),
                _buildVideoList(),
              ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.lightgray,
          ),
          SizedBox(
            height: 15,
          ),
          _buildArticleListHeader(),
          SizedBox(
            height: 10,
          ),
          _buildArticleList(),
        ],
      ),
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
      child: ListView.separated(
        padding: EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
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
                        color: AppColors.lightgray,
                        child: Center(child: Text('Video $index'))
                    ),
                    Container(
                      width: 160,
                      height: 40,
                      child: Center(
                        child: Text(
                          'วิธีการกลืนเบื้องต้น',
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
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 5);
        },
      ),
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
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.article_list);
              Navbar.selectedIndex = 3;
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
      child: _homeStore.articleList != null
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
                          color: AppColors.lightgray,
                          child: Image.network(
                            article.imgUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              return Center(
                                  child: Icon(
                                    Icons.no_photography_rounded,
                                    color: AppColors.white,
                                    size: 30,
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

  Widget _handleNoArticlesFound() {
    return Center(
      child: Text(
        'ไม่พบบทความที่คุณกำลังค้นหา...',
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 17),
      ),
    );
  }
}
