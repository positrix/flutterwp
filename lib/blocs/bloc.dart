import 'dart:async';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutterwp/config/constants.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final StreamController<List<wp.Post>> _featuredPostsController =
      BehaviorSubject<List<wp.Post>>();
  final StreamController<List<wp.Category>> _categoriesController =
      BehaviorSubject<List<wp.Category>>();

  // Variables
  static List<wp.Category> categories;
  static List<wp.Post> featuredPosts;

  Stream<List<wp.Post>> get getFeaturedPosts {
    _featuredPostsController.sink.add([]);
    return _featuredPostsController.stream.transform(_fetchFeaturedPosts);
  }

  Stream<List<wp.Category>> get getCategories {
    _categoriesController.sink.add([]);
    return _categoriesController.stream.transform(_fetchCategories);
  }

  List<wp.Post> get getStoredFeaturedPosts => featuredPosts;
  List<wp.Category> get getStoredCategories => categories;

  dispose() {
    _featuredPostsController.close();
    _categoriesController.close();
  }

  // Stream Transformers

  final _fetchFeaturedPosts =
      StreamTransformer<List<wp.Post>, List<wp.Post>>.fromHandlers(
          handleData: (featPosts, sink) async {
    wp.WordPress wordPress = wp.WordPress(
      baseUrl: kSiteUrl,
    );
    featuredPosts = await wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        perPage: kHomePageArticles,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      postType: 'posts',
      fetchFeaturedMedia: true,
    );
    sink.add(featuredPosts);
  });

  final _fetchCategories =
      StreamTransformer<List<wp.Category>, List<wp.Category>>.fromHandlers(
          handleData: (featPosts, sink) async {
    wp.WordPress wordPress = wp.WordPress(
      baseUrl: kSiteUrl,
    );
    categories = await wordPress.fetchCategories(
      params: wp.ParamsCategoryList(
        context: wp.WordPressContext.view,
        perPage: 100,
        hideEmpty: true,
      ),
    );
    sink.add(categories);
  });
}

final bloc = Bloc();
