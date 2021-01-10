import 'package:flutter/cupertino.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/stores/form/form_store.dart';
import 'package:swallowing_app/utils/device/device_utils.dart';
import 'package:swallowing_app/utils/locale/app_localization.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';
import 'package:swallowing_app/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          _buildMainContent(),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.deepblue,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildAppName(),
                  SizedBox(
                    height: 55,
                  ),
                  _buildLogInForm()
                ],
              ),
            ),
          ),
        )
      );
  }

  Widget _buildAppName() {
      return Text(
          "Swallowing\n   Therapy",
          style: TextStyle(
              fontFamily: FontFamily.roboto,
              fontWeight: FontWeight.w300,
              color: AppColors.white,
              fontSize: 45,
              decoration: TextDecoration.none
          ),
      );
  }
  Widget _buildLogInForm() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _buildUsernameField(),
              _buildPasswordField(),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        SizedBox(
          width: 300,
          child: _buildPatientSignInBtn(),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 300,
          child: _buildGuestSignInBtn(),
        )
      ],
    );
  }

  Widget _buildUsernameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'ชื่อผู้ใช้',
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: Colors.black54,
          textController: _usernameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_usernameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.username,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'รหัสผ่าน',
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.password,
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildPatientSignInBtn() {
    return  FlatButton(
        height: 40,
        color: AppColors.babyblue,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppColors.babyblue,
              width: 3,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () async {
          if (_store.canLogin) {
            DeviceUtils.hideKeyboard(context);
            _store.login(context);
          }
        },
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(
            fontFamily: FontFamily.kanit,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        )
    );
  }

  Widget _buildGuestSignInBtn() {
    return FlatButton(
        height: 40,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppColors.babyblue,
              width: 3,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () {
          print("Guest log in");
        },
        child: Text(
          "เข้าสู่ระบบโดยไม่มีบัญชีผู้ใช้",
          style: TextStyle(
            fontFamily: FontFamily.kanit,
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        )
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((preference) {
      preference.setBool(Preferences.is_logged_in, true);
      print('is_logged_in: ${preference.getBool(Preferences.is_logged_in)}');
      print('auth_token: ${preference.getString(Preferences.auth_token)}');
      print('profile: ${preference.getString(Preferences.patient_profile)}');
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage( String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

}
