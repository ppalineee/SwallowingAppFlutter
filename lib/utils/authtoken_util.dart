import 'package:swallowing_app/data/repository.dart';

class AuthToken {
  Repository _repository;

  AuthToken(Repository repository) : this._repository = repository;

  Future loginPatient(username, password) async {
    try {
      await _repository.loginPatient(username, password);
    } catch (e) {
      rethrow;
    }
  }

  Future loginGuest() async {
    try {
      await _repository.loginGuest();
    } catch (e) {
      rethrow;
    }
  }

  Future logoutPatient() async {
    await _repository.logoutPatient();
  }

  Future logoutGuest() async {
    await _repository.logoutGuest();
  }
}
