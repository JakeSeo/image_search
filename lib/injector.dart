import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'app_router.dart';
import 'repositories/search/repository.dart';
import 'services/search_interceptor.dart';

GetIt injector = GetIt.instance;

void initInjector() {
  final baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio()..interceptors.add(SearchInterceptor());
  injector.registerLazySingleton<SearchRepository>(
      () => SearchRepository(dio, baseUrl: baseUrl!));
  injector.registerSingleton<AppRouter>(AppRouter());
}
