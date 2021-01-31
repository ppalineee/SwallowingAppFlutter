import 'dart:async';
import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'video_store.g.dart';

class VideoStore = _VideoStore with _$VideoStore;

abstract class _VideoStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _VideoStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<VideoList> emptyVideoListResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<VideoList> fetchVideoListFuture =
  ObservableFuture<VideoList>(emptyVideoListResponse);

  @observable
  VideoList videoList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchVideoListFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getVideoList() async {
    final future = _repository.getVideoList();
    fetchVideoListFuture = ObservableFuture(future);

    future.then((videoList) {
      this.videoList = videoList;
      success = true;
    }).catchError((error) {
      success = false;
    });
  }
}