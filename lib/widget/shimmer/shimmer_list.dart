import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/shimmer/shimmer_cell.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList();

  @override
  Widget build(BuildContext context) {
    final double screenHehgit = MediaQuery.of(context).size.height;
    final int numOfCell = (screenHehgit / 64).floor();
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: screenHehgit,
      color: theme.backgroundColor,
      child: ListView.builder(
        itemCount: numOfCell,
        itemBuilder: (BuildContext context, int index) => const ShimmerCell(),
      ),
    );
  }
}
