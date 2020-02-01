class ArticleModel {
  final int id;
  final String title;
  final String description;
  final String avatar; 
  
  ArticleModel.fromJSON(Map<String,dynamic> json)
    : id = json['id'] as int,
      title = json['title'],
      description = json['description'],
      avatar = json['user']['profile_image_90'];
}