part of 'bloc.dart';

class FavoriteImageState {
  final List<ImageDocumentInfo> images;
  FavoriteImageState({this.images = const []});
}

class FavoriteImageInitial extends FavoriteImageState {}

class FavoriteImageInitializing extends FavoriteImageState {}

class FavoriteImageInitialized extends FavoriteImageState {}

class LoadingFavoriteImages extends FavoriteImageState {
  LoadingFavoriteImages({super.images});
}

class LoadedFavoriteImages extends FavoriteImageState {
  LoadedFavoriteImages({super.images});
}

class FavoriteImageError extends FavoriteImageState {
  final String errorCode;
  final dynamic error;
  FavoriteImageError({required this.errorCode, this.error});
}
