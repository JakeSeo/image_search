import 'package:equatable/equatable.dart';

// 검색 항목 부모 객체
abstract class SearchDocumentInfo extends Equatable {
  final SearchType searchType;
  const SearchDocumentInfo({required this.searchType});
  Map<String, dynamic> toJson();
  @override
  List<Object?> get props => [searchType];
}

// 검색 항목 enum
enum SearchType {
  web,
  vclip,
  image,
  blog,
  book,
  cafe;
}
