part of 'bloc.dart';

class SearchHistoryEvent {}

class SearchHistoryInitialize extends SearchHistoryEvent {}

class LoadSearchHistory extends SearchHistoryEvent {
  final String query;
  LoadSearchHistory({this.query = ""});
}

class AddQuery extends SearchHistoryEvent {
  final String query;
  AddQuery({required this.query});
}

class DeleteQuery extends SearchHistoryEvent {
  final String query;
  DeleteQuery({required this.query});
}

class ClearSearchHistory extends SearchHistoryEvent {}
