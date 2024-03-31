part of 'bloc.dart';

class SearchEvent {}

class SearchInitialize extends SearchEvent {}

class Search extends SearchEvent {
  final String query;
  Search({required this.query});
}

class LoadMore extends SearchEvent {}
