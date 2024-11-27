import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/components/checkerboard_background.dart';
import 'package:demo_app/screens/home/home_controller.dart';
import 'package:demo_app/screens/home/home_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A view for the [HomeRoute].
class HomeView extends StatelessWidget {
  /// A controller for this view.
  final HomeController state;

  /// Creates an instance of [HomeView].
  const HomeView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const CheckerboardBackground(),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                BrutalistContainer(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32.0, 32.0, 8.0, 64.0),
                        child: Image.asset(
                          'assets/apple_intelligence.png',
                          width: 42,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32.0, 32.0, 64.0, 64.0),
                        child: Text(
                          AppLocalizations.of(context)!.welcomeMessage,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(128.0, 64.0, 16.0, 32.0),
                  child: BrutalistContainer(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            AppLocalizations.of(context)!.featuresHeader,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          height: 32.0,
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            bottom: 16.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.featureItemCount,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          height: 4.0,
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                            height: 2.0,
                            thickness: 2.0,
                          ),
                        ),
                        Container(
                          height: 64,
                          width: 64,
                          child: Placeholder(),
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          height: 32.0,
                          thickness: 2.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
