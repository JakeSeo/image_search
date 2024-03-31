part of 'bloc.dart';

class SearchHistoryState {
  final List<String> history;
  SearchHistoryState({this.history = const []});
}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryInitializing extends SearchHistoryState {}

class SearchHistoryInitialized extends SearchHistoryState {}

class LoadingSearchHistory extends SearchHistoryState {
  LoadingSearchHistory({super.history});
}

class LoadedSearchHistory extends SearchHistoryState {
  LoadedSearchHistory({super.history});
}

class SearchHistoryError extends SearchHistoryState {
  final String errorCode;
  final dynamic error;
  SearchHistoryError({required this.errorCode, this.error});
}
