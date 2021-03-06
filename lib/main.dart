import 'package:camera/camera.dart';
import 'package:swallowing_app/constants/app_theme.dart';
import 'package:swallowing_app/constants/strings.dart';
import 'package:swallowing_app/di/components/app_component.dart';
import 'package:swallowing_app/di/modules/local_module.dart';
import 'package:swallowing_app/di/modules/network_module.dart';
import 'package:swallowing_app/di/modules/preference_module.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/stores/article_store.dart';
import 'package:swallowing_app/stores/assignment_store.dart';
import 'package:swallowing_app/stores/home_store.dart';
import 'package:swallowing_app/stores/language/language_store.dart';
import 'package:swallowing_app/stores/notification_store.dart';
import 'package:swallowing_app/stores/post/post_store.dart';
import 'package:swallowing_app/stores/profile_store.dart';
import 'package:swallowing_app/stores/theme/theme_store.dart';
import 'package:swallowing_app/stores/video_store.dart';
import 'package:swallowing_app/ui/splash.dart';
import 'package:swallowing_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:inject/inject.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/utils/authtoken_util.dart';
import 'package:swallowing_app/widgets/camera_widget.dart';

AppComponent appComponent;
List<CameraDescription> cameras = [];

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) async {
    appComponent = await AppComponent.create(
      NetworkModule(),
      LocalModule(),
      PreferenceModule(),
    );
    runApp(appComponent.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  final ThemeStore _themeStore = ThemeStore(appComponent.getRepository());
  final PostStore _postStore = PostStore(appComponent.getRepository());
  final LanguageStore _languageStore =
      LanguageStore(appComponent.getRepository());
  final AuthToken _authToken = AuthToken(appComponent.getRepository());
  final ProfileStore _profileStore = ProfileStore(appComponent.getRepository());
  final ArticleStore _articleStore = ArticleStore(appComponent.getRepository());
  final HomeStore _homeStore = HomeStore(appComponent.getRepository());
  final VideoStore _videoStore = VideoStore(appComponent.getRepository());
  final AssignmentStore _assignmentStore = AssignmentStore(appComponent.getRepository());
  final NotificationStore _notificationStore = NotificationStore(appComponent.getRepository());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<AuthToken>(create: (_) => _authToken),
        Provider<ProfileStore>(create: (_) => _profileStore),
        Provider<ArticleStore>(create: (_) => _articleStore),
        Provider<HomeStore>(create: (_) => _homeStore),
        Provider<VideoStore>(create: (_) => _videoStore),
        Provider<AssignmentStore>(create: (_) => _assignmentStore),
        Provider<NotificationStore>(create: (_) => _notificationStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
