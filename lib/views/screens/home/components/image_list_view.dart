import 'package:flutter/material.dart';

import '../../../../models/search_document/image_document/info.dart';
import 'image_element_widget.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({
    super.key,
    this.controller,
    required this.images,
  });

  final ScrollController? controller;
  final List<ImageDocumentInfo> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      controller: controller,
      itemCount: images.length,
      clipBehavior: Clip.antiAlias,
      itemBuilder: (context, index) {
        final image = images[index];
        return ImageElementWidget(image: image);
      },
    );
  }
}
