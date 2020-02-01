import 'dart:convert';

import 'package:flutterrestgraphql/features/articles/ArticleModel.dart';
import 'package:http/http.dart' as http;
class ArticleService {

  static String _url = "https://dev.to/api/articles";

  // GET /articles
  static Future<List<ArticleModel>> browse() async {
    http.Response response = await http.get("$_url");
    String payload = response.body;

    List collection = json.decode(payload);
    Iterable<ArticleModel> elements = collection
      .map((_) => ArticleModel.fromJSON(_));
    
    return elements.toList();
  }

  // GET /articles/:id
  static Future<ArticleModel> fetch(){

  }

}

void main() async {
  List r =  await ArticleService.browse();
  print(r);
}