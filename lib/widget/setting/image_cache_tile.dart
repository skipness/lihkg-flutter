import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class ImageCacheTile extends StatefulWidget {
  @override
  State createState() => _ImageCacheTileState();
}

class _ImageCacheTileState extends State<ImageCacheTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
        future: DiskCache().cacheSize(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListTile(
                  title: Text('圖片緩存：${(snapshot.data / 1E6).floor()} MB'),
                  trailing: FlatButton(
                      child: Text('清理圖片緩存',
                          style: TextStyle(color: theme.errorColor)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      onPressed: () => DiskCache().clear().then((success) {
                            if (success) {
                              setState(() {});
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('清理圖片緩存失敗'),
                                  duration: const Duration(seconds: 5)));
                            }
                          })));
            case ConnectionState.waiting:
              return ListTile(title: Text('計算圖片緩存中⋯'));
            default:
              return ListTile(
                  title: Text('讀取圖片緩存失敗',
                      style: TextStyle(color: theme.errorColor)));
          }
        });
  }
}
