import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/profile.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _ProfileStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Profile> emptyProfileResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<Profile> fetchProfileFuture =
  ObservableFuture<Profile>(emptyProfileResponse);

  @observable
  Profile profile;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchProfileFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPatientProfile() async {
    final future = _repository.getPatientProfile();
    fetchProfileFuture = ObservableFuture(future);

    future.then((profile) {
      this.profile = profile;
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = error.message;
      success = false;
    });
  }
}
