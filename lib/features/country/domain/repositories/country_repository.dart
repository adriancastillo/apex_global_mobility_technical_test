
import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getCountries();
}
