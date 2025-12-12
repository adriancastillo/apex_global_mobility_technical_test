import 'package:apex_global_mobility_test/features/country/presentation/providers/country_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:apex_global_mobility_test/features/country/domain/uses_case/fetch_countries.dart';

class MockFetchCountries extends Mock implements FetchCountries {}

void main() {
  late MockFetchCountries mockUseCase;

  setUp(() {
    mockUseCase = MockFetchCountries();
  });

  test('Should load countries when provider initializes', () async {
    // Arrange
    when(() => mockUseCase()).thenAnswer(
      (_) async => const [Country(code: 'CO', name: 'Colombia', emoji: '🇨🇴')],
    );

    final container = ProviderContainer(
      overrides: [
        countryProvider.overrideWith(() => CountryNotifier(mockUseCase)),
      ],
    );

    // Act
    final result = await container.read(countryProvider.future);

    // Assert
    expect(result.length, 1);
    expect(result.first.code, 'CO');
    verify(() => mockUseCase()).called(1);
  });

  test('Should refresh and emit new values when refresh is called', () async {
    // Arrange
    when(() => mockUseCase()).thenAnswer(
      (_) async => const [
        Country(code: 'US', name: 'United States', emoji: '🇺🇸'),
      ],
    );

    final container = ProviderContainer(
      overrides: [
        countryProvider.overrideWith(() => CountryNotifier(mockUseCase)),
      ],
    );

    // Act
    final notifier = container.read(countryProvider.notifier);

    // before refresh
    expect(container.read(countryProvider).isLoading, true);

    await notifier.refresh();

    // Assert
    final state = container.read(countryProvider);

    expect(state.hasValue, true);
    expect(state.value!.first.code, 'US');
  });

  test('Should set error state when fetch countries fails', () async {
    // Arrange
    final exception = Exception('Error fetching countries');

    when(() => mockUseCase()).thenThrow(exception);

    final container = ProviderContainer(
      overrides: [
        countryProvider.overrideWith(() => CountryNotifier(mockUseCase)),
      ],
    );

    // Act
    final future = container.read(countryProvider.future);

    // Assert
    await expectLater(future, throwsA(isA<Exception>()));

    final state = container.read(countryProvider);

    expect(state, isA<AsyncError<List<Country>>>());

    expect(state.error, exception);
  });
}
