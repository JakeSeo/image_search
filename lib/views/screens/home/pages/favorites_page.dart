import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/favorite_image/bloc.dart';
import '../components/image_list_view.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteImageBloc>().add(LoadFavoriteImages());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text("즐겨찾기")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<FavoriteImageBloc, FavoriteImageState>(
          builder: (context, state) {
            if (state is! LoadedFavoriteImages) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.images.isEmpty) {
              return const Center(
                child: Text(
                  "즐겨찾기에 추가된 이미지가 없습니다.\n좋아하는 이미지를 검색해서 추가해보세요!",
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ImageListView(images: state.images);
          },
        ),
      ),
    );
  }
}
