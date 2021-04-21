import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:swallowing_app/utils/authtoken_util.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin && username.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      username.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && username.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    username = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validateUsername(String value) {
    if (value.isEmpty) {
      formErrorStore.username = "กรุณาระบุชื่อผู้ใช้";
    } else {
      formErrorStore.username = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "กรุณาระบุรหัสผ่าน";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password does't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  Future register() async {
    loading = true;
  }

  @action
  Future loginPatient(BuildContext context) async {
    loading = true;
    try {
      AuthToken _authToken = Provider.of<AuthToken>(context, listen: false);
      await _authToken.loginPatient(username, password);
      loading = false;
      success = true;
    } catch(e) {
      loading = false;
      success = false;
      if (e.message.contains("wrong username or password")) {
        formErrorStore.username = "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง";
      } else {
        errorStore.errorMessage = "เครือข่ายขัดข้อง กรุณาเชื่อมต่อเครือข่าย";
      }
    }
  }

  @action
  Future loginGuest(BuildContext context) async {
    loading = true;
    try {
      AuthToken _authToken = Provider.of<AuthToken>(context, listen: false);
      await _authToken.loginGuest();
      loading = false;
      success = true;
    } catch(e) {
      loading = false;
      success = false;
      errorStore.errorMessage = "เครือข่ายขัดข้อง กรุณาเชื่อมต่อเครือข่าย";
    }
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUsername(username);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String username;

  @observable
  String password;

  @observable
  String confirmPassword;

  @computed
  bool get hasErrorsInLogin => username != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      username != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => username != null;
}
