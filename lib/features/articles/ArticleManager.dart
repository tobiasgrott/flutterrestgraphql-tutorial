import 'package:flutterrestgraphql/features/articles/ArticleModel.dart';
import 'package:flutterrestgraphql/features/articles/ArticleService.dart';
import 'package:rxdart/rxdart.dart';

class ArticleManager {

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<ArticleModel>> _collectionSubject = PublishSubject<List<ArticleModel>>();

  Stream<List<ArticleModel>> get browse$ => _collectionSubject.stream;
  Sink<String> get inFilter =>  _filterSubject.sink;

  ArticleManager(){
    _filterSubject.switchMap((filter) async* {
      yield await ArticleService.browse();
    }).listen((collection) { 
      _collectionSubject.add(collection);
    });
  }

}