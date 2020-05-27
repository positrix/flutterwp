import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterwp/config/constants.dart';

class SiteLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.5,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(kSiteLogo),
        ),
      ),
    );
  }
}
