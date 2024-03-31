import '../search_document/info.dart';
import '../search_meta/info.dart';

abstract class SearchResponseInfo {
  final SearchMetaInfo meta;
  final List<SearchDocumentInfo> documents;

  SearchResponseInfo({
    required this.meta,
    required this.documents,
  });
}
