import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_router.dart';
import 'blocs/favorite_image/bloc.dart';
import 'blocs/search/bloc.dart';
import 'blocs/search_history/bloc.dart';
import 'injector.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  initInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchImageBloc>(create: (_) => SearchImageBloc()),
        BlocProvider<SearchHistoryBloc>(create: (_) => SearchHistoryBloc()),
        BlocProvider<FavoriteImageBloc>(create: (_) => FavoriteImageBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: injector.get<AppRouter>().appRouter,
        title: '다음 검색',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
