import 'package:flutter/material.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';
import 'package:lihkg_flutter/widget/message/youtube.dart';
import 'package:share/share.dart';

class MediaView extends StatefulWidget {
  final int initialPage;
  final List<MediaContent> mediaContents;

  MediaView(this.initialPage, this.mediaContents);

  @override
  State createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> {
  int currentPage;
  bool isZooming = false;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    setState(() {
      currentPage = widget.initialPage;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('${currentPage + 1} / ${widget.mediaContents.length}')),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon:
                  Icon(Icons.keyboard_arrow_left, color: theme.iconTheme.color),
              onPressed: () => _pageController.previousPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOutExpo),
            ),
            IconButton(
                icon: Icon(Icons.share, color: theme.iconTheme.color),
                onPressed: () {
                  if (widget.mediaContents[currentPage].url != null) {
                    Share.share(widget.mediaContents[currentPage].url);
                  }
                }),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right,
                  color: theme.iconTheme.color),
              onPressed: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOutExpo),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: isZooming
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        itemCount: widget.mediaContents.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: theme.backgroundColor,
            child: SafeArea(
                child: widget.mediaContents[index].type == MediaType.IMAGE
                    ? ZoomableWidget(
                        minScale: 1.0,
                        maxScale: 3.0,
                        zoomSteps: 1,
                        autoCenter: true,
                        onZoomChanged: (double zoom) {
                          if (zoom > 1.0) {
                            setState(() {
                              isZooming = true;
                            });
                          } else {
                            setState(() {
                              isZooming = false;
                            });
                          }
                        },
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                              '${widget.mediaContents[index].url}',
                              useDiskCache: true,
                              cacheRule:
                                  CacheRule(maxAge: const Duration(days: 7))),
                          fit: BoxFit.contain,
                          loadingWidgetBuilder: (double progress) => Center(
                                  child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 2,
                              )),
                          placeholder: Icon(Icons.error,
                              color: theme.iconTheme.color, size: 45),
                          disableMemoryCacheIfFailed: true,
                        ),
                      )
                    : Youtube(
                        youtubeId: widget.mediaContents[index].youtubeId)),
          );
        },
      ),
    );
  }
}
