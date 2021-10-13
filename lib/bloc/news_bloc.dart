import 'dart:async';

import 'package:news_bloc/models/article_model.dart';
import 'package:news_bloc/services/api_service.dart';

enum NewsAction { fetch, delete }

class NewsBloc {
  ApiService cliente = ApiService();

  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var news = await cliente.getArticle();
          _newsSink.add(news);
        } on Exception catch (e) {
          _newsSink.addError('Something is wrong' + e.toString());
        }
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
