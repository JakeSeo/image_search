part of 'bloc.dart';

class SearchState {
  final List<SearchDocumentInfo> documents;
  final bool isEnd;

  SearchState({
    this.documents = const [],
    this.isEnd = false,
  });
}

class SearchInitial extends SearchState {}

class SearchInitialized extends SearchState {}

class Searching extends SearchState {}

class LoadingMore extends SearchState {
  LoadingMore({super.isEnd, super.documents});
}

class Searched extends SearchState {
  Searched({super.isEnd, super.documents});
}

class SearchError extends SearchState {
  final String errorCode;
  final dynamic error;
  SearchError({required this.errorCode, this.error});
}
