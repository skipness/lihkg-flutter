import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ImageView extends StatefulWidget {
  final String url;
  final int cacheAge;
  final bool compress;
  final BoxFit fit;
  final bool shouldLoad;

  ImageView(
      {@required this.url,
      this.cacheAge = 7,
      this.compress = true,
      this.fit = BoxFit.contain,
      this.shouldLoad = true});

  @override
  State createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  ImageProvider imageProvider;
  double width = 30;

  @override
  void initState() {
    imageProvider = AdvancedNetworkImage(
        widget.compress ? 'https://i.lihkg.com/540/${widget.url}' : widget.url,
        useDiskCache: true,
        cacheRule: CacheRule(maxAge: Duration(days: widget.cacheAge)));
    imageProvider
        .resolve(ImageConfiguration())
        .addListener((ImageInfo info, bool _) {
      if (!mounted) return;
      setState(() {
        width = info.image.width.toDouble();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return widget.shouldLoad
        ? TransitionToImage(
            image: imageProvider,
            width: width > size.width ? size.width : width,
            fit: widget.fit,
            loadingWidgetBuilder: (double progress) => Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(15),
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                )),
            disableMemoryCacheIfFailed: true,
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.camera_alt,
                size: 50, color: Theme.of(context).disabledColor));
  }
}
