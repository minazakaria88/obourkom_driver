import 'package:flutter/material.dart';

import '../../../../../core/widgets/shimmer_item.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) => const ShimmerItem(
        width: 80,
        height: 80,
        margin: 5,
      ),
      itemCount: 10,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
      ),
    );
  }
}
