import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutterwp/config/helper_functions.dart';
import 'package:flutterwp/screens/post_screen.dart';
import 'package:html_character_entities/html_character_entities.dart';

class PostFeaturedTile extends StatelessWidget {
  const PostFeaturedTile({@required this.post});

  final wp.Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostScreen(postId: post.id))),
        child: Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              post.featuredMedia != null
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              post.featuredMedia.sourceUrl),
                        ),
                      ),
                    )
                  : Text('no image'),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      post.title.rendered != null
                          ? HtmlCharacterEntities.decode(post.title.rendered)
                          : 'null',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    post.excerpt.rendered != null
                        ? Html(
                            data: cleanShortcodes(post.excerpt.rendered),
                          )
                        : Text('null'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
