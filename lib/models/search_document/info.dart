import 'package:equatable/equatable.dart';

abstract class SearchDocumentInfo extends Equatable {
  final SearchType searchType;
  const SearchDocumentInfo({required this.searchType});
  Map<String, dynamic> toJson();
  @override
  List<Object?> get props => [searchType];
}

enum SearchType {
  web,
  vclip,
  image,
  blog,
  book,
  cafe;
}
