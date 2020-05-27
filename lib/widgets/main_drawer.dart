import 'package:flutter/material.dart';
import 'package:flutterwp/blocs/bloc.dart';
import 'package:flutterwp/widgets/main_header_drawer.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:html_character_entities/html_character_entities.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (bloc.getStoredCategories == null) {
      return Drawer(
        child: StreamBuilder(
          stream: bloc.getCategories,
          builder: (context, AsyncSnapshot<List<wp.Category>> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: LinearProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MainDrawerHeader();
                }
                return ListTile(
                    title: Text(HtmlCharacterEntities.decode(
                        snapshot.data[index - 1].name)));
              },
            );
          },
        ),
      );
    } else {
      return Drawer(
        child: ListView.builder(
          itemCount: bloc.getStoredCategories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return MainDrawerHeader();
            }
            return ListTile(
                title: Text(HtmlCharacterEntities.decode(
                    bloc.getStoredCategories[index - 1].name)));
          },
        ),
      );
    }
  }
}
