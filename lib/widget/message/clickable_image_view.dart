import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/message/image_view.dart';

class ClickableImageView extends StatefulWidget {
  final String url;

  ClickableImageView({@required this.url});

  @override
  _ClickableImageViewState createState() => _ClickableImageViewState();
}

class _ClickableImageViewState extends State<ClickableImageView>
    with AutomaticKeepAliveClientMixin {
  bool shouldLoad;
  bool didLoad = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setState(() {
      // shouldLoad = SharedPreferencesHelper.getShouldAutoLoadImage() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ImageView(url: widget.url, shouldLoad: true);
    // return Container(
    //     color: Colors.yellow,
    //     child: InkWell(
    //         key: UniqueKey(),
    //         onTap: () => setState(() {
    //               print('state');
    //               shouldLoad = true;
    //               // didLoad = true;
    //             }),
    //         child: shouldLoad
    //             ? ImageView(url: widget.url, shouldLoad: true)
    //             : ImageView(url: widget.url, shouldLoad: false)));
  }
}
