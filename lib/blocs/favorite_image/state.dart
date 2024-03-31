part of 'bloc.dart';

class FavoriteImageState {
  final List<ImageDocumentInfo> imageList;
  FavoriteImageState({this.imageList = const []});
}

class FavoriteImageInitial extends FavoriteImageState {}

class FavoriteImageInitializing extends FavoriteImageState {}

class FavoriteImageInitialized extends FavoriteImageState {}

class LoadingFavoriteImageList extends FavoriteImageState {
  LoadingFavoriteImageList({super.imageList});
}

class LoadedFavoriteImageList extends FavoriteImageState {
  LoadedFavoriteImageList({super.imageList});
}

class FavoriteImageError extends FavoriteImageState {
  final String errorCode;
  final dynamic error;
  FavoriteImageError({required this.errorCode, this.error});
}
