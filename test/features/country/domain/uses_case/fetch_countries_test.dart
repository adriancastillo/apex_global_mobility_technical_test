import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:apex_global_mobility_test/features/country/domain/repositories/country_repository.dart';
import 'package:apex_global_mobility_test/features/country/domain/uses_case/fetch_countries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements CountryRepository {}

void main() {
  late FetchCountries usecase;
  late MockRepository repository;

  setUp(() {
    repository = MockRepository();
    usecase = FetchCountries(repository);
  });

  test('Should return country list when repository returns data', () async {
    when(() => repository.getCountries()).thenAnswer(
      (_) async => const [Country(code: "BR", name: "Brasil", emoji: "🇧🇷")],
    );

    final result = await usecase();

    expect(result.first.name, "Brasil");
    verify(() => repository.getCountries()).called(1);
  });

  test('Should throw an exception when repository fails', () async {
    when(
      () => repository.getCountries(),
    ).thenThrow(Exception('Error fetching countries'));

    expect(() async => await usecase(), throwsA(isA<Exception>()));

    verify(() => repository.getCountries()).called(1);
  });
}
