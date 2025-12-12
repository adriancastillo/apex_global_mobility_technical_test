import 'package:apex_global_mobility_test/shared/routes/route_names.dart';
import 'package:apex_global_mobility_test/shared/ui/components/button.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: UIPadding.horizontal_24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Apex Global Mobility App',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              UISpacing.vertical_32,
              AgmButton(
                fullWidth: true,
                text: 'Todos',
                onPressed: () {
                  context.goNamed(RouteNames.todos);
                },
              ),
              UISpacing.vertical_16,
              AgmButton(
                fullWidth: true,
                text: 'Countries',
                onPressed: () {
                  context.goNamed(RouteNames.countries);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
