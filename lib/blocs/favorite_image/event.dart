part of 'bloc.dart';

class FavoriteImageEvent {}

class FavoriteImageInitialize extends FavoriteImageEvent {}

class LoadFavoriteImages extends FavoriteImageEvent {}

class FavoriteImage extends FavoriteImageEvent {
  final ImageDocumentInfo image;
  FavoriteImage({required this.image});
}

class UnfavoriteImage extends FavoriteImageEvent {
  final ImageDocumentInfo image;
  UnfavoriteImage({required this.image});
}
