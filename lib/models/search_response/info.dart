import '../search_document/info.dart';
import '../search_meta/info.dart';

// 검색 결과 부모 객체
// 검색 항목별로 구성요소가 다 똑같아서 부모객체로 정의
abstract class SearchResponseInfo {
  final SearchMetaInfo meta;
  final List<SearchDocumentInfo> documents;

  SearchResponseInfo({
    required this.meta,
    required this.documents,
  });
}
