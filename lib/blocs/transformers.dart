import 'dart:async';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutterwp/config/constants.dart';

class Transformers {
  final fetchFeaturedPosts =
      StreamTransformer<List<wp.Post>, List<wp.Post>>.fromHandlers(
          handleData: (featPosts, sink) async {
    wp.WordPress wordPress = wp.WordPress(
      baseUrl: kSiteUrl,
    );
    final _featuredPosts = await wordPress.fetchPosts(
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
    sink.add(_featuredPosts);
  });

  final fetchCategories =
      StreamTransformer<List<wp.Category>, List<wp.Category>>.fromHandlers(
          handleData: (featPosts, sink) async {
    wp.WordPress wordPress = wp.WordPress(
      baseUrl: kSiteUrl,
    );
    final _categories = await wordPress.fetchCategories(
      params: wp.ParamsCategoryList(
        context: wp.WordPressContext.view,
        perPage: 100,
      ),
    );
    sink.add(_categories);
  });
}
