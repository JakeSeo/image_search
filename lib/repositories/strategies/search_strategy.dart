import '../../injector.dart';
import '../../models/search_query_parameter/info.dart';
import '../../models/search_response/image/info.dart';
import '../../models/search_response/info.dart';
import '../search/repository.dart';

// 이미지 외 다른 항목 검색하는 기능을 추가하기 위해 strategy 패턴을 사용해서 해당 검색항목 처리
abstract class SearchStrategy {
  final SearchRepository repository = injector.get<SearchRepository>();

  Future<SearchResponseInfo> search({
    required String query,
    SortType? sort,
    int? page,
    int? size,
    TargetType? target,
  });
}

class SearchImageStrategy extends SearchStrategy {
  @override
  Future<SearchImageResponseInfo> search({
    required String query,
    SortType? sort,
    int? page,
    int? size,
    TargetType? target,
  }) async {
    return await repository.searchImage(
      param: SearchQueryParameterInfo(
        query: query,
        sort: sort,
        page: page,
        size: size,
      ),
    );
  }
}
