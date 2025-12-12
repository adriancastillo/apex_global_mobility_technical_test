import 'package:apex_global_mobility_test/features/country/presentation/countries_view.dart';
import 'package:apex_global_mobility_test/shared/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:apex_global_mobility_test/features/country/domain/uses_case/fetch_countries.dart';
import 'package:apex_global_mobility_test/features/country/presentation/providers/country_provider.dart';
import 'package:apex_global_mobility_test/features/country/presentation/widgets/country_item.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';

class MockFetchCountries extends Mock implements FetchCountries {}

Widget buildTestApp({required List<Override> overrides}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: CountriesView(),
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

  const countriesMock = <Country>[
    Country(code: 'CO', name: 'Colombia', emoji: '🇨🇴'),
    Country(code: 'AR', name: 'Argentina', emoji: '🇦🇷'),
    Country(code: 'CL', name: 'Chile', emoji: '🇨🇱'),
  ];

  const refreshedMock = <Country>[
    Country(code: 'BR', name: 'Brazil', emoji: '🇧🇷'),
    Country(code: 'PE', name: 'Peru', emoji: '🇵🇪'),
  ];

  group('CountryView - widget tests', () {
    late MockFetchCountries mockFetch;

    setUp(() {
      mockFetch = MockFetchCountries();
    });

    testWidgets(
      'Should show loading indicator when countries are being fetched',
      (tester) async {
        when(() => mockFetch()).thenAnswer((_) async => countriesMock);

        final overrides = <Override>[
          countryProvider.overrideWith(() => CountryNotifier(mockFetch)),
        ];

        await tester.pumpWidget(buildTestApp(overrides: overrides));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();

        expect(find.byType(CountryItem), findsNWidgets(countriesMock.length));
        verify(() => mockFetch()).called(1);
      },
    );

    testWidgets(
      'Should render countries list when fetchCountries returns data',
      (tester) async {
        when(() => mockFetch()).thenAnswer((_) async => countriesMock);

        final overrides = <Override>[
          countryProvider.overrideWith(() => CountryNotifier(mockFetch)),
        ];

        await tester.pumpWidget(buildTestApp(overrides: overrides));
        await tester.pumpAndSettle();

        expect(find.byType(CountryItem), findsNWidgets(countriesMock.length));
        expect(find.text('Colombia'), findsOneWidget);
        expect(find.text('Argentina'), findsOneWidget);
        expect(find.text('Chile'), findsOneWidget);
        expect(find.text('🇨🇴'), findsOneWidget);

        verify(() => mockFetch()).called(1);
      },
    );

    testWidgets(
      'Should display error and retry button when fetchCountries throws',
      (tester) async {
        when(() => mockFetch()).thenThrow(Exception('Network failed'));

        final overrides = <Override>[
          countryProvider.overrideWith(() => CountryNotifier(mockFetch)),
        ];

        await tester.pumpWidget(buildTestApp(overrides: overrides));
        await tester.pumpAndSettle();

        expect(find.text('¡Ups! ocurrió un error'), findsOneWidget);
        expect(find.widgetWithText(AgmButton, 'Reintentar'), findsOneWidget);

        verify(() => mockFetch()).called(1);
      },
    );

    testWidgets('Should reload list when app bar refresh button is pressed', (
      tester,
    ) async {
      when(() => mockFetch()).thenAnswer((_) async => countriesMock);

      final overrides = <Override>[
        countryProvider.overrideWith(() => CountryNotifier(mockFetch)),
      ];

      await tester.pumpWidget(buildTestApp(overrides: overrides));
      await tester.pumpAndSettle();

      expect(find.text('Colombia'), findsOneWidget);
      expect(find.text('Brazil'), findsNothing);

      when(() => mockFetch()).thenAnswer((_) async => refreshedMock);

      final refreshButton = find.byType(IconButton);
      expect(refreshButton, findsOneWidget);

      await tester.tap(refreshButton);

      await tester.pumpAndSettle();

      expect(find.text('Brazil'), findsOneWidget);
      expect(find.text('Peru'), findsOneWidget);

      verify(() => mockFetch()).called(2);
    });

    testWidgets('Should reload list when pull-to-refresh is performed', (
      tester,
    ) async {
      when(() => mockFetch()).thenAnswer((_) async => countriesMock);

      final overrides = <Override>[
        countryProvider.overrideWith(() => CountryNotifier(mockFetch)),
      ];

      await tester.pumpWidget(buildTestApp(overrides: overrides));
      await tester.pumpAndSettle();

      expect(find.text('Colombia'), findsOneWidget);
      expect(find.text('Brazil'), findsNothing);

      when(() => mockFetch()).thenAnswer((_) async => refreshedMock);

      final listFinder = find.byType(ListView);
      expect(listFinder, findsOneWidget);

      await tester.drag(listFinder, const Offset(0, 300));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Brazil'), findsOneWidget);
      expect(find.text('Peru'), findsOneWidget);

      verify(() => mockFetch()).called(2);
    });

    testWidgets(
      'Should call refresh and render data when retry button is pressed after error',
      (tester) async {
        when(() => mockFetch()).thenThrow(Exception('Network failed'));

        final overrides = <Override>[
          countryProvider.overrideWith(() => CountryNotifier(mockFetch)),
        ];

        await tester.pumpWidget(buildTestApp(overrides: overrides));
        await tester.pumpAndSettle();

        expect(find.text('¡Ups! ocurrió un error'), findsOneWidget);
        expect(find.widgetWithText(AgmButton, 'Reintentar'), findsOneWidget);

        when(() => mockFetch()).thenAnswer((_) async => refreshedMock);

        await tester.tap(find.widgetWithText(AgmButton, 'Reintentar'));
        await tester.pump();
        await tester.pumpAndSettle();

        expect(find.text('Brazil'), findsOneWidget);
        expect(find.text('Peru'), findsOneWidget);

        verify(() => mockFetch()).called(greaterThanOrEqualTo(2));
      },
    );
  });
}
