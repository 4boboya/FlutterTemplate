import 'package:auto_route/auto_route.dart';
import 'package:flutter_application/presentation/screens/home/main.dart';
import 'package:flutter_application/presentation/screens/login/main.dart';
import 'package:flutter_application/presentation/screens/test/main.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: LoginPage, initial: true),
    AutoRoute(path: '/home', page: MyHomePage),
    AutoRoute(path: '/test', page: TestPage),
  ],
)
class $AppRouter {}
