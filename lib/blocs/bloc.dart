import 'dart:async';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutterwp/config/constants.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final StreamController<List<wp.Post>> _newestPostsController =
      BehaviorSubject<List<wp.Post>>();
  final StreamController<List<wp.Category>> _categoriesController =
      BehaviorSubject<List<wp.Category>>();

  // Variables
  static List<wp.Category> categories = [];
  static List<wp.Post> newestPosts = [];
  static bool isLoadingPosts = false;
  static bool endReached = false;

  Stream<List<wp.Post>> get getNewestPosts {
    _newestPostsController.sink.add(newestPosts);
    return _newestPostsController.stream.transform(_fetchNewestPosts);
  }

  Stream<List<wp.Category>> get getCategories {
    _categoriesController.sink.add([]);
    return _categoriesController.stream.transform(_fetchCategories);
  }

  List<wp.Post> get getStoredNewestPosts => newestPosts;
  List<wp.Category> get getStoredCategories => categories;
  bool get getIsLoadingPosts => isLoadingPosts;

  dispose() {
    _newestPostsController.close();
    _categoriesController.close();
  }

  // Stream Transformers

  final _fetchNewestPosts =
      StreamTransformer<List<wp.Post>, List<wp.Post>>.fromHandlers(
          handleData: (featPosts, sink) async {
    if (isLoadingPosts == false && endReached == false) {
      isLoadingPosts = true;
      print('fetching posts');
      List<wp.Post> _oldPosts;
      if (featPosts != null) {
        _oldPosts = featPosts;
      }

      final int _fetchPage = (_oldPosts.length / kHomePageArticles).round() + 1;

      wp.WordPress wordPress = wp.WordPress(
        baseUrl: kSiteUrl,
      );
      try {
        newestPosts = await wordPress
            .fetchPosts(
          postParams: wp.ParamsPostList(
            context: wp.WordPressContext.view,
            pageNum: _fetchPage,
            perPage: kHomePageArticles,
            order: wp.Order.desc,
            orderBy: wp.PostOrderBy.date,
          ),
          postType: 'posts',
          fetchFeaturedMedia: true,
        )
            .catchError((err) {
          endReached = true;
          print('error occured');
        });
      } catch (e) {}

      newestPosts = _oldPosts + newestPosts;
      sink.add(newestPosts);
      print('finished fetching posts');
      isLoadingPosts = false;
    }
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
