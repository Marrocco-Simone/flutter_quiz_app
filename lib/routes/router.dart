import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../styles/colors.dart';
import '../screens/practice_screen.dart';
import '../screens/main_screen.dart';
import '../screens/topic_screen.dart';
import '../screens/stats_screen.dart';

GoRouter getRouter() {
  return GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
              body: SingleChildScrollView(child: MainScreen()),
              backgroundColor: homePageColor,
            )),
    GoRoute(
        path: '/topic/:topicId',
        builder: (context, state) {
          final int topicId = int.parse(state.pathParameters['topicId']!);
          final String continueUrl = '/topic/$topicId';
          return Scaffold(
            body: SingleChildScrollView(
                child: TopicScreen(
              topicId: topicId,
              continueUrl: continueUrl,
            )),
            backgroundColor: homePageColor,
          );
        }),
    GoRoute(
        path: '/stats',
        builder: (context, state) => const Scaffold(
              body: SingleChildScrollView(child: StatsScreen()),
              backgroundColor: homePageColor,
            )),
    GoRoute(
        path: '/practice',
        builder: (context, state) => const Scaffold(
              body: SingleChildScrollView(child: PracticeScreen()),
              backgroundColor: homePageColor,
            )),
  ]);
}
