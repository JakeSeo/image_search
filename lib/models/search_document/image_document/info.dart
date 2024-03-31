import 'package:json_annotation/json_annotation.dart';

import '../info.dart';

part 'info.g.dart';

@JsonSerializable()
class ImageDocumentInfo extends SearchDocumentInfo {
  @JsonKey(name: "collection")
  final String collection;
  @JsonKey(name: "thumbnail_url")
  final String thumbnailUrl;
  @JsonKey(name: "image_url")
  final String imageUrl;
  @JsonKey(name: "width")
  final int width;
  @JsonKey(name: "height")
  final int height;
  @JsonKey(name: "display_sitename")
  final String displaySitename;
  @JsonKey(name: "doc_url")
  final String docUrl;
  @JsonKey(name: "datetime")
  final DateTime datetime;
  const ImageDocumentInfo({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.displaySitename,
    required this.docUrl,
    required this.datetime,
  }) : super(searchType: SearchType.image);

  factory ImageDocumentInfo.fromJson(Map<String, dynamic> json) =>
      _$ImageDocumentInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageDocumentInfoToJson(this);

  @override
  List<Object?> get props => [
        super.searchType,
        imageUrl,
        displaySitename,
        docUrl,
      ];
}
