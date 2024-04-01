import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Search 관련 dio 클라이언트에 반복되는 작업을 추가하기위한 Interceptor
// 현재는 api_key를 Authorization으로 추가하는 부분만 구현되어 있음.
class SearchInterceptor extends QueuedInterceptor {
  SearchInterceptor();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final bool needsApiKey = options.headers.remove("api_key") ?? false;

    if (!needsApiKey) {
      super.onRequest(options, handler);
      return;
    }

    options.headers.addAll(
      {
        "Authorization": "KakaoAK ${dotenv.env["REST_API_KEY"]}",
      },
    );
    super.onRequest(options, handler);
  }
}
