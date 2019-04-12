import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCell extends StatelessWidget {
  const ShimmerCell();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 10),
        // color: theme.backgroundColor,
        child: Shimmer.fromColors(
          baseColor: theme.dividerColor,
          highlightColor: theme.splashColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      width: double.infinity,
                      height: 23.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      width: MediaQuery.of(context).size.width / 2,
                      height: 16.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
