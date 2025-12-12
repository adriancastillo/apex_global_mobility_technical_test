import 'package:apex_global_mobility_test/features/country/data/data_sources/country_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:apex_global_mobility_test/features/country/domain/repositories/country_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CountryRepository)
class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remote;

  CountryRepositoryImpl(this.remote);

  @override
  Future<List<Country>> getCountries() async {
    final models = await remote.getCountries();
    return models.map((e) => e.toEntity()).toList();
  }
}
