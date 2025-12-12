import 'package:apex_global_mobility_test/features/country/data/data_sources/country_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/country/data/models/country_model.dart';
import 'package:apex_global_mobility_test/features/country/data/repositories/country_repository_impl.dart';
import 'package:apex_global_mobility_test/features/country/domain/repositories/country_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemote extends Mock implements CountryRemoteDataSource {}

void main() {
  late CountryRepository repository;
  late MockRemote remote;

  setUp(() {
    remote = MockRemote();
    repository = CountryRepositoryImpl(remote);
  });

  test(
    'Should return list of countries when remote datasource succeeds',
    () async {
      when(() => remote.getCountries()).thenAnswer(
        (_) async => [
          CountryModel(code: "AR", name: "Argentina", emoji: "🇦🇷"),
        ],
      );

      final result = await repository.getCountries();

      expect(result.length, 1);
      expect(result.first.name, "Argentina");
    },
  );

  test('Should throw an exception when remote datasource fails', () {
    when(() => remote.getCountries()).thenThrow(Exception());
    expect(repository.getCountries(), throwsException);
  });
}
