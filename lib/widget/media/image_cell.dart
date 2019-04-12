import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/message/image_view.dart';

class ImageCell extends StatelessWidget {
  final String url;

  ImageCell({@required this.url});

  @override
  Widget build(BuildContext context) => ImageView(url: url, fit: BoxFit.cover);
}
