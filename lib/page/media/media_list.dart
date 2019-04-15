import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/media/media_cell.dart';
import 'package:lihkg_flutter/widget/media/empty_view.dart';
import 'package:lihkg_flutter/page/page.dart';

class MediaList extends StatefulWidget {
  final String threadId;
  final bool includeLink;

  MediaList({@required this.threadId, this.includeLink});

  @override
  State createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  MediaBloc _mediaBloc;

  @override
  void initState() {
    _mediaBloc = MediaBloc(threadId: widget.threadId, includeLink: widget.includeLink);
    super.initState();
  }

  @override
  void dispose() {
    _mediaBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('媒體模式'),
        ),
        body: BlocBuilder<MediaEvent, MediaState>(
            bloc: _mediaBloc,
            builder: (BuildContext context, MediaState state) {
              if (state is MediaUninitialized) {
                return Container(
                    color: theme.backgroundColor,
                    child: const Center(
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ));
              }

              if (state is MediaError) return const SizedBox();
              if (state is MediaLoaded) {
                return state.items.isEmpty
                    ? EmptyView()
                    : OrientationBuilder(
                        builder:
                            (BuildContext context, Orientation orentation) =>
                                Container(
                                  color: theme.backgroundColor,
                                  child: SafeArea(
                                      bottom: false,
                                      child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 2.0,
                                              crossAxisSpacing: 2.0,
                                              crossAxisCount:
                                                  orentation == Orientation.portrait
                                                      ? 3
                                                      : 4),
                                          itemCount: state.items.length,
                                          itemBuilder: (BuildContext context, int index) => InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MediaView(
                                                          index, state.items))),
                                              child: state.items[index].type == MediaType.IMAGE
                                                  ? ImageCell(url: state.items[index].url)
                                                  : YoutubeCell(youtubeId: state.items[index].youtubeId)))),
                                ));
              }
            }));
  }
}
