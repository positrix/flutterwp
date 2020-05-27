import 'package:flutter/material.dart';
import 'package:flutterwp/widgets/site_logo.dart';

class MainAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Icon(
          Icons.view_headline,
          size: 30,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: false,
      title: SiteLogo(),
    );
  }
}
