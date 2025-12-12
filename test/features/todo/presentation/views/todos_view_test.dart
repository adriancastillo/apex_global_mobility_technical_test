import 'package:apex_global_mobility_test/shared/ui/components/button.dart';
import 'package:apex_global_mobility_test/shared/ui/components/checkbox.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/fetch_todos.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/register_todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/update_todo.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_provider.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_filter_provider.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/views/todos_view.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';

class MockFetchTodos extends Mock implements FetchTodos {}

class MockRegisterTodo extends Mock implements RegisterTodo {}

class MockUpdateTodo extends Mock implements UpdateTodo {}

Widget buildTestApp({
  required Widget child,
  required List<Override> overrides,
}) {
  final router = GoRouter(
    routes: [GoRoute(path: '/', name: 'todos', builder: (_, __) => child)],
  );

  return ProviderScope(
    overrides: overrides,
    child: MaterialApp.router(
      routerConfig: router,
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final todosMock = <Todo>[
    const Todo(id: 1, title: 'New todo 1', completed: false),
    const Todo(id: 2, title: 'New todo 2', completed: true),
  ];

  final todoMock = const Todo(id: 1, title: 'New todo', completed: false);

  late MockFetchTodos mockFetch;
  late MockRegisterTodo mockRegister;
  late MockUpdateTodo mockUpdate;

  group('TodosView - widget tests', () {
    setUp(() {
      mockFetch = MockFetchTodos();
      mockRegister = MockRegisterTodo();
      mockUpdate = MockUpdateTodo();

      when(() => mockFetch()).thenAnswer((_) async => todosMock);
      when(
        () => mockRegister(any()),
      ).thenAnswer((_) async => Future.value(todoMock));
      when(
        () => mockUpdate(any()),
      ).thenAnswer((_) async => Future.value(todoMock));
    });

    setUpAll(() {
      registerFallbackValue(
        const Todo(id: -1, title: 'New todo', completed: false),
      );
    });

    testWidgets(
      'Should render todos list when fetchTodos completes successfully',
      (tester) async {
        final overrides = <Override>[
          todosProvider.overrideWith(
            (ref) =>
                TodoNotifier(mockFetch, mockRegister, mockUpdate)..fetchTodos(),
          ),

          todoFilterProvider.overrideWith((ref) => TodoFilter.all),
        ];

        await tester.pumpWidget(
          buildTestApp(child: const TodosView(), overrides: overrides),
        );
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();

        for (final todo in todosMock) {
          expect(find.text(todo.title), findsOneWidget);
        }
      },
    );

    testWidgets('Should update todo status when checkbox is toggled', (
      tester,
    ) async {
      final overrides = <Override>[
        todosProvider.overrideWith(
          (ref) =>
              TodoNotifier(mockFetch, mockRegister, mockUpdate)..fetchTodos(),
        ),
        todoFilterProvider.overrideWith((ref) => TodoFilter.all),
      ];

      await tester.pumpWidget(
        buildTestApp(child: const TodosView(), overrides: overrides),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AgmCheckbox).first);
      await tester.pumpAndSettle();

      verify(() => mockUpdate(any(that: isA<Todo>()))).called(1);
    });

    testWidgets('Should add new todo to the list when form is submitted', (
      tester,
    ) async {
      final overrides = <Override>[
        todosProvider.overrideWith(
          (ref) =>
              TodoNotifier(mockFetch, mockRegister, mockUpdate)..fetchTodos(),
        ),
        todoFilterProvider.overrideWith((ref) => TodoFilter.all),
      ];

      await tester.pumpWidget(
        buildTestApp(child: const TodosView(), overrides: overrides),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      const title = 'Crear nueva tarea';
      await tester.enterText(find.byType(TextField), title);
      await tester.tap(find.widgetWithText(AgmButton, 'Crear'));
      await tester.pumpAndSettle();

      verify(() => mockRegister(any(that: isA<Todo>()))).called(1);
      expect(find.text(title), findsOneWidget);
    });
  });
}
