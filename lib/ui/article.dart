import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';

class ArticleScreen extends StatefulWidget {
  final Article article;

  ArticleScreen({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('บทความ', true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height - 118,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: _buildMainContent()
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.article.title,
              style: TextStyle(
                color: AppColors.deepblue,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            )
          ),
          Divider(
            thickness: 1,
            color: AppColors.gray,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Image.network(
              widget.article.imgUrl,
              fit: BoxFit.contain,
              errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                return Container(
                    width: 200,
                    height: 120,
                    color: AppColors.lightgray,
                    child: Icon(
                      Icons.no_photography_rounded,
                      color: Colors.black45,
                      size: 30,
                    )
                );
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.article.content,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ]
      ),
    );
  }
}