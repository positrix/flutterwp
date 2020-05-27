import 'package:flutter/material.dart';
import 'package:flutterwp/config/constants.dart';
import 'package:flutterwp/widgets/site_logo.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:html_character_entities/html_character_entities.dart';

class MainDrawer extends StatelessWidget {
  final List<wp.Category> categories;
  MainDrawer(this.categories);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SiteLogo(),
                  ),
                  Text(
                    kSiteName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    kSiteSupportEmail,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListTile(
              title: Text(
                  HtmlCharacterEntities.decode(categories[index - 1].name)));
        },
      ),
    );
  }
}
