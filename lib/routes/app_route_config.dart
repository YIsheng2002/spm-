import 'package:flutter/material.dart';
import 'package:testing/screens/analysis.dart';
import 'package:testing/screens/home.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/screens/subject.dart';

class MyAppRouter{
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: 'home',
          path: '/',
        pageBuilder: (context, state){
            return MaterialPage(child: Home());
        },
      ),
      GoRoute(
        name: 'Analysis',
        path: '/analysis',
        pageBuilder: (context, state){
          return MaterialPage(child: Analysis());
        },
      ),
      GoRoute(
        name: 'subject',
        path: '/subject',
        pageBuilder: (context, state){
          return MaterialPage(child: Subject());
        },
      ),
    ]
  );
}