import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/favorite_image/bloc.dart';
import '../../../../models/search_document/image_document/info.dart';
import '../../image_details_screen.dart';

class ImageElementWidget extends StatelessWidget {
  const ImageElementWidget({
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

  _goToImageDetailsScreen(BuildContext context) {
    context.pushNamed(ImageDetailsScreen.name, extra: image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToImageDetailsScreen(context),
      onDoubleTap: () => _toggleFavorite(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: image.thumbnailUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 4,
                top: 4,
                child: ActionChip(
                  onPressed: () => _toggleFavorite(context),
                  side: BorderSide.none,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(
                    side: BorderSide.none,
                  ),
                  label: Text(
                    image.displaySitename,
                  ),
                  labelPadding: image.displaySitename.isEmpty
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(right: 8),
                  avatar: BlocBuilder<FavoriteImageBloc, FavoriteImageState>(
                    builder: (context, state) {
                      return Icon(
                        state.images.contains(image)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
