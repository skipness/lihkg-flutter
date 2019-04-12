import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/setting/setting_widget.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('設定'),
        ),
        body: Container(
          color: theme.backgroundColor,
          child: ListView(children: [
            DarkModeTile(),
            const Divider(),
            SectionHeaderTile(title: '主題列表'),
            CatListFontSizeTile(),
            const Divider(),
            SectionHeaderTile(title: '內文'),
            ThreadFontSizeTile(),
            MediaIncLinkTile(),
            // SwitchListTile(
            //   title: Text('Youtube播放器'),
            //   value: false,
            //   inactiveTrackColor: theme.dividerColor,
            //   onChanged: (value) => {},
            // ),
            const Divider(),
            SectionHeaderTile(title: '其他'),
            ImageCacheTile(),
            // AboutListTile(
            //   applicationName: 'lihkg-flutter',
            //   applicationVersion: 'alpha',
            // )
          ]),
        ));
  }
}
