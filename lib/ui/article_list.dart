import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/stores/article_store.dart';
import 'package:swallowing_app/ui/article.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';

class ArticleListScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  ArticleStore _articleStore;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _articleStore = Provider.of<ArticleStore>(context);

    if (!_articleStore.loading) {
      await _articleStore.getArticleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'บทความ', visibilityBackIcon: false),
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
              visible: !_articleStore.loading && _articleStore.success,
              child: _buildMainContent(),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _articleStore.loading || !_articleStore.success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: (_articleStore.articleList != null && _articleStore.articleList.articles.length > 0)
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _articleStore.articleList.articles.length,
              itemBuilder: (context, index) {
                int i = _articleStore.articleList.articles.length - index - 1;
                return _buildArticle(_articleStore.articleList.articles[i], i);
              },
            )
          : _handleNoArticlesFound()
        )
      );
  }

  Widget _buildArticle(Article article, int index) {
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
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 1,
        child: ClipPath(
          child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    color: AppColors.gray,
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
                ),
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                article.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: FontFamily.kanit,
                                  fontSize: 18,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                article.content,
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: FontFamily.kanit,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ]
                      ),
                    )
                ),
              ]
          ),
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)
            ),
          ),
        ),
      )
    );
  }

  Widget _handleNoArticlesFound() {
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
              'ไม่พบบทความที่คุณกำลังค้นหา...',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 20),
            ),
          )
        ]
    );
  }
}
