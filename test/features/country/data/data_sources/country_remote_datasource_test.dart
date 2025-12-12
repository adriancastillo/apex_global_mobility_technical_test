import 'package:apex_global_mobility_test/features/country/data/data_sources/country_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

class FakeQueryOptions extends Fake implements QueryOptions {}

void main() {
  late MockGraphQLClient client;
  late CountryRemoteDataSourceImpl datasource;

  setUpAll(() {
    registerFallbackValue(FakeQueryOptions());
  });

  setUp(() {
    client = MockGraphQLClient();
    datasource = CountryRemoteDataSourceImpl(client);
  });

  test(
    'Should return a list of countries when GraphQL query succeeds',
    () async {
      when(() => client.query(any())).thenAnswer(
        (_) async => QueryResult(
          data: {
            "countries": [
              {"code": "CO", "name": "Colombia", "emoji": "🇨🇴"},
            ],
          },
          source: QueryResultSource.network,
          options: QueryOptions(document: gql("")),
        ),
      );

      final result = await datasource.getCountries();

      expect(result.length, 1);
      expect(result.first.code, "CO");
    },
  );

  test('Should throw an exception when GraphQL client fails', () {
    when(() => client.query(any())).thenThrow(Exception("Server error"));

    expect(() => datasource.getCountries(), throwsException);
  });
}
