import 'package:flutter/material.dart';
import 'package:flutterwp/config/constants.dart';
import 'package:flutterwp/widgets/site_logo.dart';

class MainDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
