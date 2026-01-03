
import 'package:bit_key/features/feature_auth/presentation/auth_page.dart';
import 'package:bit_key/main.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouterConfig = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => AuthPage(),),
    GoRoute(path: '/main', builder: (context, state) => MainPage()),
  ]
);