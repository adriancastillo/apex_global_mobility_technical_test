import 'package:apex_global_mobility_test/features/country/presentation/providers/country_provider.dart';
import 'package:apex_global_mobility_test/features/country/presentation/widgets/country_item.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';
import 'package:apex_global_mobility_test/shared/ui/components/error.dart';
import 'package:apex_global_mobility_test/shared/ui/components/scaffold.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CountriesView extends ConsumerWidget {
  const CountriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(countryProvider);

    return AgmScaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.countryTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.arrowClockwise()),
            onPressed: () => ref.read(countryProvider.notifier).refresh(),
          ),
        ],
      ),
      body: state.when(
        data: (countries) => RefreshIndicator(
          onRefresh: () => ref.read(countryProvider.notifier).refresh(),
          child: ListView.separated(
            itemCount: countries.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return CountryItem(country: countries[index]);
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Column(
          children: [
            Padding(
              padding: UIPadding.all_24,
              child: AgmErrorCard(
                retry: ref.read(countryProvider.notifier).refresh,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
