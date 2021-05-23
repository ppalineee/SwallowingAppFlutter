# Swallowing Therapy Mobile Application

Swallowing Therapy Mobile Application (for patients) is created in flutter using MobX and Provider. It supports both iOS and Android.
## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/chate/SwallowingTherapy.git
```

**Step 2:**

Go to mobile project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Hide Generated Files

In-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:

```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:
```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```
## Libraries & Tools Used

* [Boilerplate Project](https://github.com/zubairehman/flutter-boilerplate-project.git)
* [Dio](https://github.com/flutterchina/dio)
* [Database](https://github.com/tekartik/sembast.dart)
* [MobX](https://github.com/mobxjs/mobx.dart) (to connect the reactive data of the application with the UI)
* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Encryption](https://github.com/xxtea/xxtea-dart)
* [Validation](https://github.com/dart-league/validators)
* [Logging](https://github.com/zubairehman/Flogs)
* [Notifications](https://github.com/AndreHaueisen/flushbar)
* [Json Serialization](https://github.com/dart-lang/json_serializable)
* [Dependency Injection](https://github.com/google/inject.dart)
* [Navigation Bar](https://github.com/55Builds/Flutter-FFNavigationBar)
* [Chewie](https://github.com/brianegan/chewie)
* [Video Thumbnail](https://github.com/justsoft/video_thumbnail)
* [HTTP Parser](https://github.com/dart-lang/http_parser)
* [Gallery Saver](https://github.com/CarnegieTechnologies/gallery_saver)
* [Liquid Pull To Refresh](https://github.com/aagarwal1012/Liquid-Pull-To-Refresh)

## Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- assets
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- data/
|- di/
|- models/
|- stores/
|- ui/
|- utils/
|- widgets/
|- main.dart
|- routes.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of the project, includes directories for local, network and shared pref/cache.
3- di - Contains the files involving with dependency injection.
4- models - Contains all data models of the project.
5- stores - Contains stores for state-management of the application, to connect the reactive data of the application with the UI. 
6- ui — Contains all the ui of the project, contains sub directory for each screen.
7- util — Contains the utilities/common functions of the application.
8- widgets — Contains the common widgets for the applications. For example, Button, TextField etc.
9- routes.dart — This file contains all the routes for the application.
10- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- app_theme.dart
|- assets.dart
|- colors.dart
|- dimens.dart
|- font_family.dart
|- strings.dart
```

### Data

All the business logic of the application will go into this directory, it represents the data layer of the application. It is sub-divided into three directories `local`, `network` and `shared_perf`, each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.

```
data/
|- local/
    |- constants/
    |- datasouces/
   
|- network/
    |- apis/
    |- constants/
    |- exceptions/
    |- dio_client.dart
    |- rest_client.dart
    
|- sharedpref
    |- constants/
    |- shared_preference_helper.dart
    
|- repository.dart
```

### DI

This directory contains all the files involving with dependency injection.

```
di/
|- components/
    |- app_components.dart
   
|- modules/
    |- local_module.dart
    |- network_module.dart
    |- preference_module.dart
```

### Models

This directory contains all the data models.

```
models/
|- articles.dart
|- assignment.dart
|- jwt_token.dart
|- notification.dart
|- profile.dart
|- thumbnail.dart
|- video.dart
```

### Stores

The store is where all the application state lives in flutter. The Store is basically a widget that stands at the top of the widget tree and passes it's data down using special methods. In-case of multiple stores, a separate folder for each store is created as shown in the example below:

```
stores/
|- articles_store.dart
|- assignment_store.dart
|- home_store.dart
|- notification_store.dart
|- profile_store.dart
|- video_store.dart
```

### UI

This directory contains all the ui of the application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:

```
ui/
|- article.dart
|- article_list.dart
|- assignment.dart
|- assignment_board.dart
|- assignment_list.dart
|- contact_us.dart
|- exercise.dart
|- home.dart
|- login.dart
|- more.dart
|- notification.dart
|- profile.dart
|- setting.dart
|- splash.dart
|- test.dart
|- video.dart
|- videoplaylist.dart
```

### Utils

Contains the common file(s) and utilities used in a project. The folder structure is as follows: 

```
utils/
|- device/
   |- device_utils.dart
|- dio/
   |- dio_error_util.dart
|- encryption/
   |- xxtea.dart
|- locale/
  |- app_localization.dart
|- authtoken_util.dart
|- date_format.dart
```

### Widgets

Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.

```
widgets/
|- app_bar_widget.dart
|- app_icon_widget.dart
|- assignment_status_widget.dart
|- camera_widget.dart
|- chewie_widget.dart
|- comment_widget.dart
|- mirror_widget.dart
|- nav_bar_widget.dart
|- post_widget.dart
|- progress_indicator_widget.dart
|- text_button_widget.dart
|- textfield_widget.dart
|- thumbnail_widget.dart
|- video_player_widget.dart
|- video_widget.dart
```

### Routes

This file contains all the routes for the application.

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
