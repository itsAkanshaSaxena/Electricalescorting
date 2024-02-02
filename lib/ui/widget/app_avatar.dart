import 'package:flutter/material.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

/*
class AppAvatar extends StatelessWidget {
  AppAvatar(this._url);
  final String _url;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return _url != null
        ? CircleAvatar(
            backgroundImage: AdvancedNetworkImage(_url,
                useDiskCache: true, fallbackAssetImage: 'images/avatar.jpg'),
          )
        : CircleAvatar(
            backgroundImage: AssetImage('images/avatar.jpg'),
          );
  }
}
*/

class AppAvatar extends StatelessWidget {
  const AppAvatar(this._url, {Key? key}) : super(key: key);
  final String _url;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return _url != null
        ? CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(_url),
          )
        : const CircleAvatar(
            backgroundImage: AssetImage('images/avatar.jpg'),
          );
  }
}