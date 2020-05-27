import 'package:flutter/material.dart';
import 'package:flutterwp/widgets/main_appbar.dart';
import 'package:flutterwp/widgets/main_drawer.dart';
import 'package:flutterwp/widgets/posts_featured_tile.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutterwp/blocs/bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Redrawing home');
    if (bloc.getStoredNewestPosts == null ||
        bloc.getStoredNewestPosts?.length == 0) {
      return Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: bloc.getNewestPosts,
            builder: (context, AsyncSnapshot<List<wp.Post>> snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              }
              List<PostFeaturedTile> _featured = [];
              snapshot.data.forEach((post) {
                _featured.add(PostFeaturedTile(post: post));
              });
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !bloc.getIsLoadingPosts) {
                    print('scroll end reached...');
                    bloc.getNewestPosts;
                  }
                  return false;
                },
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: _featured,
                ),
              );
            },
          ),
        ),
      );
    } else {
      final List<Widget> _featured = [];
      bloc.getStoredNewestPosts.forEach((post) {
        _featured.add(PostFeaturedTile(post: post));
      });
      return Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: _featured,
          ),
        ),
      );
    }
  }
}
