import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
