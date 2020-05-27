import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter/material.dart';
import 'package:flutterwp/blocs/bloc.dart';
import 'package:flutterwp/config/helper_functions.dart';
import 'package:flutterwp/widgets/main_appbar.dart';
import 'package:flutterwp/widgets/main_drawer.dart';
import 'package:html_character_entities/html_character_entities.dart';

class PostScreen extends StatelessWidget {
  final wp.Post post;
  PostScreen({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StreamBuilder(
        stream: bloc.getCategories,
        builder: (context, AsyncSnapshot<List<wp.Category>> snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return MainDrawer(snapshot.data);
        },
      ),
      appBar: MainAppbar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Container(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: post.id.toString() + 'featuredImage',
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            post.featuredMedia.sourceUrl),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        HtmlCharacterEntities.decode(post.title.rendered),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Html(
                        data: cleanShortcodes(post.content.rendered),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
