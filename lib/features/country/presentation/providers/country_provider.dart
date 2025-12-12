import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:apex_global_mobility_test/features/country/domain/uses_case/fetch_countries.dart';
import 'package:apex_global_mobility_test/shared/di/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryProvider = AsyncNotifierProvider<CountryNotifier, List<Country>>(
  () => CountryNotifier(getIt<FetchCountries>()),
);

class CountryNotifier extends AsyncNotifier<List<Country>> {
  CountryNotifier(this._fetchCountries);

  final FetchCountries _fetchCountries;

  @override
  Future<List<Country>> build() async => _fetchCountries();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchCountries());
  }
}
