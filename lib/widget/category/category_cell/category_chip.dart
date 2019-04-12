import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

class CategoryChip extends StatelessWidget {
  final String categoryName;

  const CategoryChip({@required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontScale = PreferenceContext.of(context).preference;
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            color: theme.dividerColor,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            child: Text(categoryName,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 10 * fontScale, color: theme.hintColor))));
  }
}
