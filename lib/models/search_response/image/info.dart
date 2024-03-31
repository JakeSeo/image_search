import '../../search_document/image_document/info.dart';
import '../../search_meta/info.dart';
import '../info.dart';

class SearchImageResponseInfo extends SearchResponseInfo {
  SearchImageResponseInfo({required super.meta, required super.documents});
  factory SearchImageResponseInfo.fromJson(Map<String, dynamic> json) {
    final meta = SearchMetaInfo.fromJson(json["meta"]);
    final documents = (json["documents"] as List<dynamic>)
        .map(
          (e) => ImageDocumentInfo.fromJson(e),
        )
        .toList();
    return SearchImageResponseInfo(meta: meta, documents: documents);
  }
}
