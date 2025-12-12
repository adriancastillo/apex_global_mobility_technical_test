import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:apex_global_mobility_test/features/country/domain/repositories/country_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class FetchCountries {
  final CountryRepository repository;

  FetchCountries(this.repository);

  Future<List<Country>> call() {
    return repository.getCountries();
  }
}
