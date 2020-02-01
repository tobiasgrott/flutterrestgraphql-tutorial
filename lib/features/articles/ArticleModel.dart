class ArticleModel {
  final int id;
  final String title;
  final String description;

  ArticleModel.fromJSON(Map<String,dynamic> json)
    : id = json['id'],
      title = json['title'],
      description = json['description'];
}