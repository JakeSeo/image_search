import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/search_document/image_document/info.dart';

class ImageDetailsScreen extends StatelessWidget {
  static String path = "/image-details";
  static String name = "image_details";

  const ImageDetailsScreen({
    super.key,
    required this.image,
  });

  final ImageDocumentInfo image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: image.imageUrl,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
