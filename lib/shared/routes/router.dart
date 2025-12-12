import 'package:apex_global_mobility_test/features/country/presentation/countries_view.dart';
import 'package:apex_global_mobility_test/features/home/home_view.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/views/detail_todo_view.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/views/todos_view.dart';
import 'package:apex_global_mobility_test/shared/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      pageBuilder: (context, state) => const MaterialPage(child: HomeView()),
      routes: [
        GoRoute(
          path: '/countries',
          name: RouteNames.countries,
          pageBuilder: (context, state) =>
              const MaterialPage(child: CountriesView()),
        ),
        GoRoute(
          path: '/todos',
          name: RouteNames.todos,
          pageBuilder: (context, state) =>
              const MaterialPage(child: TodosView()),
          routes: [
            GoRoute(
              path: '/detail',
              name: RouteNames.detailTodo,
              pageBuilder: (context, state) => MaterialPage(
                child: TodoDetailView(todo: state.extra as Todo),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
