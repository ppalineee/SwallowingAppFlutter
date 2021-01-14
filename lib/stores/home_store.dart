import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/ariticle.dart';
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
  static ObservableFuture<ArticleList> emptyArticleListResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<ArticleList> fetchArticleListFuture =
  ObservableFuture<ArticleList>(emptyArticleListResponse);

  @observable
  ArticleList articleList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchArticleListFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getArticleList() async {
    final future = _repository.getArticleList();
    fetchArticleListFuture = ObservableFuture(future);

    future.then((articleList) {
      this.articleList = articleList;
      success = true;
    }).catchError((error) {
      success = false;
    });
  }
}