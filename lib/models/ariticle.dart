class ArticleList {
  final List<Article> articles;

  ArticleList({
    this.articles,
  });

  factory ArticleList.fromJson(List<dynamic> json) {
    List<Article> articles = List<Article>();
    articles = json.map((article) => Article.fromJson(article)).toList();

    return ArticleList(
      articles: articles,
    );
  }
}

class Article {
  String id;
  String title;
  String content;
  String imgUrl;

  Article({
    this.id,
    this.title,
    this.content,
    this.imgUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["_id"],
    title: json["title"],
    content: json["detail"],
    imgUrl: json["photo"],
  );

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    imgUrl: json["imgUrl"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "content": content,
    "imgUrl": imgUrl,
  };

}