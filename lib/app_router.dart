import 'package:go_router/go_router.dart';

import '../views/screens/home/screen.dart';
import 'models/search_document/image_document/info.dart';
import 'views/screens/image_details_screen.dart';

class AppRouter {
  final GoRouter appRouter = GoRouter(
    initialLocation: HomeScreen.path,
    routes: [
      GoRoute(
        name: HomeScreen.name,
        path: HomeScreen.path,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        name: ImageDetailsScreen.name,
        path: ImageDetailsScreen.path,
        builder: (context, state) {
          return ImageDetailsScreen(
            image: state.extra as ImageDocumentInfo,
          );
        },
      ),
    ],
  );
}
