import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_wordpress/schemas/post.dart';
import 'package:flutterwp/config/constants.dart';
import 'package:flutterwp/widgets/posts_featured_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    wp.WordPress wordPress;

    wordPress = wp.WordPress(
      baseUrl: kSiteUrl,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(kSiteName),
      ),
      body: Container(
        child: FutureBuilder(
          future: wordPress.fetchPosts(
            postParams: wp.ParamsPostList(
              context: wp.WordPressContext.view,
              pageNum: 1,
              perPage: kHomePageArticles,
              order: wp.Order.desc,
              orderBy: wp.PostOrderBy.date,
            ),
            postType: 'posts',
            fetchFeaturedMedia: true,
          ),
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final Post _post = snapshot.data[index];
                return PostFeaturedTile(post: _post);
              },
            );
          },
        ),
      ),
    );
  }
}
