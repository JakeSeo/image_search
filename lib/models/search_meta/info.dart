import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

// 검색 결과의 메터데이터 객체
@JsonSerializable()
class SearchMetaInfo {
  @JsonKey(name: "total_count")
  final int totalCount;
  @JsonKey(name: "pageable_count")
  final int pageableCount;
  @JsonKey(name: "is_end")
  final bool isEnd;
  SearchMetaInfo({
    required this.totalCount,
    required this.pageableCount,
    required this.isEnd,
  });
  factory SearchMetaInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchMetaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMetaInfoToJson(this);
}
