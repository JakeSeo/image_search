import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/views/screens/webview_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../../blocs/favorite_image/bloc.dart';
import '../../models/search_document/image_document/info.dart';

// 이미지 상세 정보 화면
class ImageDetailsScreen extends StatelessWidget {
  static String path = "/image-details";
  static String name = "image_details";

  const ImageDetailsScreen({
    super.key,
    required this.image,
  });

  final ImageDocumentInfo image;
  _toggleFavorite(BuildContext context) {
    final bloc = context.read<FavoriteImageBloc>();
    if (bloc.state.images.contains(image)) {
      bloc.add(UnfavoriteImage(image: image));
    } else {
      bloc.add(FavoriteImage(image: image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          image.displaySitename.isEmpty ? "-" : image.displaySitename,
        ),
        actions: [
          BlocBuilder<FavoriteImageBloc, FavoriteImageState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => _toggleFavorite(context),
                icon: Icon(
                  state.images.contains(image)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: image.imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Share.share(image.imageUrl);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text("이미지 공유"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.pushNamed(
                      WebviewScreen.name,
                      queryParameters: {
                        "url": image.docUrl,
                      },
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("방문"),
                        SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
