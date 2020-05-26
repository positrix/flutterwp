import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter/material.dart';
import 'package:flutterwp/config/constants.dart';
import 'package:flutterwp/config/helper_functions.dart';
import 'package:html_character_entities/html_character_entities.dart';

class PostScreen extends StatelessWidget {
  final int postId;
  PostScreen({this.postId});

  @override
  Widget build(BuildContext context) {
    wp.WordPress wordPress;

    wordPress = wp.WordPress(
      baseUrl: kSiteUrl,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: wordPress.fetchPosts(
              postParams: wp.ParamsPostList(
                includePostIDs: [postId],
                context: wp.WordPressContext.view,
              ),
              postType: 'posts',
              fetchFeaturedMedia: true,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final wp.Post _post = snapshot.data[0];
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              _post.featuredMedia.sourceUrl),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            HtmlCharacterEntities.decode(_post.title.rendered),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Html(
                            data: cleanShortcodes(_post.content.rendered),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
