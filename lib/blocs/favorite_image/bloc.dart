import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/search_document/image_document/info.dart';
part 'event.dart';
part 'state.dart';

class FavoriteImageBloc extends Bloc<FavoriteImageEvent, FavoriteImageState> {
  FavoriteImageBloc() : super(FavoriteImageInitial()) {
    on<FavoriteImageInitialize>(_initialize);
    on<LoadFavoriteImages>(_loadFavoriteImages);
    on<FavoriteImage>(_favoriteImage);
    on<UnfavoriteImage>(_unfavoriteImage);
  }

  late SharedPreferences sharedPreferences;

  _initialize(
      FavoriteImageInitialize event, Emitter<FavoriteImageState> emit) async {
    emit(FavoriteImageInitializing());
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      emit(FavoriteImageInitialized());
      add(LoadFavoriteImages());
    } catch (e) {
      emit(FavoriteImageError(errorCode: "FIB-0001", error: e));
    }
  }

  _loadFavoriteImages(
      LoadFavoriteImages event, Emitter<FavoriteImageState> emit) async {
    if (state is LoadingFavoriteImages) return;
    emit(
      LoadingFavoriteImages(
        images: [...state.images],
      ),
    );
    try {
      final jsonStringList =
          sharedPreferences.getStringList("favorite_image_list") ?? [];

      final images = jsonStringList
          .map((jsonString) =>
              ImageDocumentInfo.fromJson(jsonDecode(jsonString)))
          .toList();
      emit(LoadedFavoriteImages(images: images));
    } catch (e) {
      emit(FavoriteImageError(errorCode: "FIB-0002", error: e));
    }
  }

  _favoriteImage(FavoriteImage event, Emitter<FavoriteImageState> emit) {
    emit(LoadedFavoriteImages(images: [event.image, ...state.images]));

    sharedPreferences.setStringList(
      "favorite_image_list",
      state.images
          .map(
            (image) => jsonEncode(
              image.toJson(),
            ),
          )
          .toList(),
    );
  }

  _unfavoriteImage(UnfavoriteImage event, Emitter<FavoriteImageState> emit) {
    final images = [...state.images];
    images.removeWhere((image) => image == event.image);
    emit(LoadedFavoriteImages(images: images));

    sharedPreferences.setStringList(
      "favorite_image_list",
      state.images
          .map(
            (image) => jsonEncode(
              image.toJson(),
            ),
          )
          .toList(),
    );
  }
}
