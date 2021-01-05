import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('หน้าหลัก', false),
      body: _buildBody(context),
      bottomNavigationBar: Navbar(),
    );
  }

  // Widget _buildThemeButton() {
  //   return Observer(
  //     builder: (context) {
  //       return IconButton(
  //         onPressed: () {
  //           _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
  //         },
  //         icon: Icon(
  //           _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildLogoutButton() {
  //   return IconButton(
  //     onPressed: () {
  //       SharedPreferences.getInstance().then((preference) {
  //         preference.setBool(Preferences.is_logged_in, false);
  //         Navigator.of(context).pushReplacementNamed(Routes.login);
  //       });
  //     },
  //     icon: Icon(
  //       Icons.power_settings_new,
  //     ),
  //   );
  // }
  //
  // Widget _buildLanguageButton() {
  //   return IconButton(
  //     onPressed: () {
  //       _buildLanguageDialog();
  //     },
  //     icon: Icon(
  //       Icons.language,
  //     ),
  //   );
  // }

  Widget _buildBody(context) {
    return Stack(
      children: <Widget>[
        // _handleErrorMessage(),
        _buildMainContent(context),
      ],
    );
  }

  Widget _buildMainContent(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Column(
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Container(
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
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 160,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
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
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'วิธีการกลืนเบื้องต้น',
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
                ),
              ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1.0,
            color: AppColors.lightgray,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
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
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 160,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 20, right: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
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
                              child: Center(child: Text('Article $index'))
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                'วิธีการกลืนเบื้องต้น',
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
          ),
        ],
      ),
    );
  }

  // Widget _buildMainContent() {
  //   return Observer(
  //     builder: (context) {
  //       return _postStore.loading
  //           ? CustomProgressIndicatorWidget()
  //           : Material(child: _buildListView());
  //     },
  //   );
  // }

  // Widget _buildListView() {
  //   return _postStore.postList != null
  //       ? ListView.separated(
  //     itemCount: _postStore.postList.posts.length,
  //     separatorBuilder: (context, position) {
  //       return Divider();
  //     },
  //     itemBuilder: (context, position) {
  //       return _buildListItem(position);
  //     },
  //   )
  //       : Center(
  //     child: Text(
  //       AppLocalizations.of(context).translate('home_tv_no_post_found'),
  //     ),
  //   );
  // }
  //
  // Widget _buildListItem(int position) {
  //   return ListTile(
  //     dense: true,
  //     leading: Icon(Icons.cloud_circle),
  //     title: Text(
  //       '${_postStore.postList.posts[position].title}',
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //       softWrap: false,
  //       style: Theme.of(context).textTheme.title,
  //     ),
  //     subtitle: Text(
  //       '${_postStore.postList.posts[position].body}',
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //       softWrap: false,
  //     ),
  //   );
  // }
  //
  // Widget _handleErrorMessage() {
  //   return Observer(
  //     builder: (context) {
  //       if (_postStore.errorStore.errorMessage.isNotEmpty) {
  //         return _showErrorMessage(_postStore.errorStore.errorMessage);
  //       }
  //
  //       return SizedBox.shrink();
  //     },
  //   );
  // }
  //
  // // General Methods:-----------------------------------------------------------
  // _showErrorMessage(String message) {
  //   Future.delayed(Duration(milliseconds: 0), () {
  //     if (message != null && message.isNotEmpty) {
  //       FlushbarHelper.createError(
  //         message: message,
  //         title: AppLocalizations.of(context).translate('home_tv_error'),
  //         duration: Duration(seconds: 3),
  //       )..show(context);
  //     }
  //   });
  //
  //   return SizedBox.shrink();
  // }
  //
  // _buildLanguageDialog() {
  //   _showDialog<String>(
  //     context: context,
  //     child: MaterialDialog(
  //       borderRadius: 5.0,
  //       enableFullWidth: true,
  //       title: Text(
  //         AppLocalizations.of(context).translate('home_tv_choose_language'),
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16.0,
  //         ),
  //       ),
  //       headerColor: Theme.of(context).primaryColor,
  //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //       closeButtonColor: Colors.white,
  //       enableCloseButton: true,
  //       enableBackButton: false,
  //       onCloseButtonClicked: () {
  //         Navigator.of(context).pop();
  //       },
  //       children: _languageStore.supportedLanguages
  //           .map(
  //             (object) => ListTile(
  //           dense: true,
  //           contentPadding: EdgeInsets.all(0.0),
  //           title: Text(
  //             object.language,
  //             style: TextStyle(
  //               color: _languageStore.locale == object.locale
  //                   ? Theme.of(context).primaryColor
  //                   : _themeStore.darkMode ? Colors.white : Colors.black,
  //             ),
  //           ),
  //           onTap: () {
  //             Navigator.of(context).pop();
  //             // change user language based on selected locale
  //             _languageStore.changeLanguage(object.locale);
  //           },
  //         ),
  //       )
  //           .toList(),
  //     ),
  //   );
  // }
  //
  // _showDialog<T>({BuildContext context, Widget child}) {
  //   showDialog<T>(
  //     context: context,
  //     builder: (BuildContext context) => child,
  //   ).then<void>((T value) {
  //     // The value passed to Navigator.pop() or null.
  //   });
  // }
}
