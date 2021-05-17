import 'package:path_provider/path_provider.dart';
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

  Future logout() async {
    await _repository.logout();
    // await _deleteCacheDir();
    // await _deleteAppDir();
  }

  /// this will delete cache
  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if(appDir.existsSync()){
      appDir.deleteSync(recursive: true);
    }
  }
}
