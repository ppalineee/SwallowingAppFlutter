import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/stores/article_store.dart';
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
      appBar: MyAppBar('บทความ', false),
      body: _buildBody(),
      bottomNavigationBar: Navbar(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildMainContent(),
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
    return Observer(
      builder: (context) {
        return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: _articleStore.articleList != null
              ? Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _articleStore.articleList.articles.length,
                  itemBuilder: (context, index) {
                    return _buildArticle(_articleStore.articleList.articles[index], index);
                  },
                )
              )
              : Expanded(
                child: Column(
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
                )
              )
            )
        );
      },
    );
  }

  Widget _buildArticle(Article article, int index) {
    return Card(
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
                    height: MediaQuery.of(context).size.width * Dimens.video_height / Dimens.video_width / 2,
                    color: AppColors.lightgray,
                    child: Center(child: Text('Picture $index'))
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
    );
  }
}
