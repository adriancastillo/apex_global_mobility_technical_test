import 'package:apex_global_mobility_test/features/country/data/data_sources/country_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/country/data/data_sources/query.dart';
import 'package:apex_global_mobility_test/features/country/data/models/country_model.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CountryRemoteDataSource)
class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  CountryRemoteDataSourceImpl(this.client);
  
  final GraphQLClient client;

  @override
  Future<List<CountryModel>> getCountries() async {
    final result = await client.query(
      QueryOptions(document: gql(getCountriesQuery)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List countries = result.data!['countries'];

    return countries.map((json) => CountryModel.fromJson(json)).toList();
  }
}
