import 'package:swallowing_app/data/local/constants/db_constants.dart';
import 'package:sembast/sembast.dart';
import 'package:swallowing_app/models/ariticle.dart';

class ArticleDataSource {
  final _articlesStore = intMapStoreFactory.store(DBConstants.STORE_NAME);
  final Future<Database> _db;

  ArticleDataSource(this._db);

  Future<int> insert(Article article) async {
    return await _articlesStore.add(await _db, article.toMap());
  }

  Future<int> count() async {
    return await _articlesStore.count(await _db);
  }

  Future<List<Article>> getAllSortedByFilter({List<Filter> filters}) async {
    final finder = Finder(
        filter: Filter.and(filters),
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _articlesStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final article = Article.fromMap(snapshot.value);
      return article;
    }).toList();
  }

  Future<ArticleList> getArticlesFromDb() async {
    print('Loading from database');

    var articlesList;

    final recordSnapshots = await _articlesStore.find(
      await _db,
    );

    if(recordSnapshots.length > 0) {
      articlesList = ArticleList(
          articles: recordSnapshots.map((snapshot) {
            final article = Article.fromMap(snapshot.value);
            return article;
          }).toList());
    }

    return articlesList;
  }

  Future<int> update(Article article) async {
    final finder = Finder(filter: Filter.byKey(article.id));
    return await _articlesStore.update(
      await _db,
      article.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Article article) async {
    final finder = Finder(filter: Filter.byKey(article.id));
    return await _articlesStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _articlesStore.drop(
      await _db,
    );
  }

}