import 'package:flutter/material.dart';

import '../../models/search_document/image_document/info.dart';

class ImageDetailsScreen extends StatelessWidget {
  static String path = "/image-details";
  static String name = "image_details";

  const ImageDetailsScreen({
    super.key,
    required this.imageDocument,
  });

  final ImageDocumentInfo imageDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
