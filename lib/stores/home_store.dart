import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _HomeStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<VideoList> emptyVideoListResponse =
  ObservableFuture.value(null);

  static ObservableFuture<ArticleList> emptyArticleListResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<VideoList> fetchVideoListFuture =
  ObservableFuture<VideoList>(emptyVideoListResponse);

  @observable
  ObservableFuture<ArticleList> fetchArticleListFuture =
  ObservableFuture<ArticleList>(emptyArticleListResponse);

  @observable
  VideoList videoList;

  @observable
  ArticleList articleList;

  @observable
  // ignore: non_constant_identifier_names
  bool video_success = false;

  @observable
  // ignore: non_constant_identifier_names
  bool article_success = false;

  @computed
  // ignore: non_constant_identifier_names
  bool get video_loading => fetchVideoListFuture.status == FutureStatus.pending;

  @computed
  // ignore: non_constant_identifier_names
  bool get article_loading => fetchArticleListFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getVideoList() async {
    final future = _repository.getVideoList();
    fetchVideoListFuture = ObservableFuture(future);

    future.then((videoList) {
      this.videoList = videoList;
      video_success = true;
    }).catchError((error) {
      video_success = false;
    });
  }

  @action
  Future getArticleList() async {
    final future = _repository.getArticleList();
    fetchArticleListFuture = ObservableFuture(future);

    future.then((articleList) {
      this.articleList = articleList;
      article_success = true;
    }).catchError((error) {
      article_success = false;
    });
  }
}