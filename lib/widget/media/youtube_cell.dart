import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/message/image_view.dart';

class YoutubeCell extends StatelessWidget {
  final String youtubeId;

  YoutubeCell({@required this.youtubeId});

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.black,
          ),
          ImageView(
              url: 'https://img.youtube.com/vi/$youtubeId/default.jpg',
              compress: false,
              fit: BoxFit.cover),
          Image.asset(
            'assets/youtube-play.webp',
            height: 50,
            width: 50,
          ),
        ],
      );
}
