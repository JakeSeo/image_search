import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class SearchQueryParameterInfo {
  @JsonKey(name: "query")
  final String query;
  @JsonKey(name: "sort")
  final SortType? sort;
  @JsonKey(name: "page")
  final int? page;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "target")
  final TargetType? target;

  SearchQueryParameterInfo({
    required this.query,
    this.sort,
    this.page,
    this.size,
    this.target,
  });

  factory SearchQueryParameterInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryParameterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchQueryParameterInfoToJson(this);
}

enum SortType {
  @JsonValue("accuracy")
  accuracy,
  @JsonValue("recency")
  recency,
}

enum TargetType {
  @JsonValue("title")
  title,
  @JsonValue("isbn")
  isbn,
  @JsonValue("publisher")
  publisher,
  @JsonValue("person")
  person,
}
