import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_konsi/features/home/home_screen.dart';
import 'package:test_konsi/features/map/router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
    ),
    ...MapRouter.routes,
  ],
);
