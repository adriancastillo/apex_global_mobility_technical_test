import 'package:apex_global_mobility_test/features/country/data/models/country_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getCountries();
}
