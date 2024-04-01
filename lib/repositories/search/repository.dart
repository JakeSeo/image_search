import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../models/search_query_parameter/info.dart';
import '../../models/search_response/image/info.dart';

part 'repository.g.dart';

@RestApi()
abstract class SearchRepository {
  factory SearchRepository(Dio dio, {String baseUrl}) = _SearchRepository;

  @GET("/v2/search/image")
  @Headers({'api_key': true})
  Future<SearchImageResponseInfo> searchImage({
    @Queries() required SearchQueryParameterInfo param,
  });

  // TODO: 나머지 검색항목 관련 API들 추가 (블로그, 카페, 북 등등)
}
