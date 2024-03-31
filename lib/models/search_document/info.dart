abstract class SearchDocumentInfo {
  final SearchType searchType;
  SearchDocumentInfo({required this.searchType});
  Map<String, dynamic> toJson();
}

enum SearchType {
  web,
  vclip,
  image,
  blog,
  book,
  cafe;
}
