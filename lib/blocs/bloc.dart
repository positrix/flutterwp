import 'dart:async';

import 'package:flutterwp/blocs/transformers.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:rxdart/rxdart.dart';

class Bloc extends Transformers {
  final StreamController<List<wp.Post>> _featuredPostsController =
      BehaviorSubject<List<wp.Post>>();
  final StreamController<List<wp.Category>> _categoriesController =
      BehaviorSubject<List<wp.Category>>();

  Stream<List<wp.Post>> get getFeaturedPosts {
    setFeaturedPosts([]);
    return _featuredPostsController.stream.transform(fetchFeaturedPosts);
  }

  Stream<List<wp.Category>> get getCategories {
    setCategories([]);
    return _categoriesController.stream.transform(fetchCategories);
  }

  Function(List<wp.Post>) get setFeaturedPosts =>
      _featuredPostsController.sink.add;
  Function(List<wp.Category>) get setCategories =>
      _categoriesController.sink.add;

  dispose() {
    _featuredPostsController.close();
    _categoriesController.close();
  }
}

final bloc = Bloc();
