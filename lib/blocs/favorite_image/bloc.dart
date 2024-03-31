import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/search_document/image_document/info.dart';
part 'event.dart';
part 'state.dart';

class FavoriteImageBloc extends Bloc<FavoriteImageEvent, FavoriteImageState> {
  FavoriteImageBloc() : super(FavoriteImageInitial()) {
    on<FavoriteImageInitialize>(_initialize);
    on<LoadFavoriteImageList>(_loadFavoriteImageList);
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
      add(LoadFavoriteImageList());
    } catch (e) {
      emit(FavoriteImageError(errorCode: "FIB-0001", error: e));
    }
  }

  _loadFavoriteImageList(
      LoadFavoriteImageList event, Emitter<FavoriteImageState> emit) async {
    if (state is LoadingFavoriteImageList) return;
    emit(
      LoadingFavoriteImageList(
        imageList: [...state.imageList],
      ),
    );
    try {
      final jsonStringList =
          sharedPreferences.getStringList("favorite_image_list") ?? [];

      final imageList = jsonStringList
          .map((jsonString) =>
              ImageDocumentInfo.fromJson(jsonDecode(jsonString)))
          .toList();
      emit(LoadedFavoriteImageList(imageList: imageList));
    } catch (e) {
      emit(FavoriteImageError(errorCode: "FIB-0002", error: e));
    }
  }

  _favoriteImage(FavoriteImage event, Emitter<FavoriteImageState> emit) {
    emit(LoadedFavoriteImageList(imageList: [event.image, ...state.imageList]));

    sharedPreferences.setStringList(
      "favorite_image_list",
      state.imageList
          .map(
            (image) => jsonEncode(
              image.toJson(),
            ),
          )
          .toList(),
    );
  }

  _unfavoriteImage(UnfavoriteImage event, Emitter<FavoriteImageState> emit) {
    final imageList = [...state.imageList];
    imageList.removeWhere((image) => image == event.image);
    emit(LoadedFavoriteImageList(imageList: imageList));

    sharedPreferences.setStringList(
      "favorite_image_list",
      state.imageList
          .map(
            (image) => jsonEncode(
              image.toJson(),
            ),
          )
          .toList(),
    );
  }
}
