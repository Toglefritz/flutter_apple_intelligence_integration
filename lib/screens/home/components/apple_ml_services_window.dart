import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/home/components/service_badge.dart';
import 'package:demo_app/services/apple_machine_learning_service.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A container including icons for Apple Machine Learning services.
///
/// This widget is a container designed to emulate the appearance of windows in 1980s versions of MacOS. The window
/// includes a series of icons, each corresponding to a different service offered by Apple's machine learning
/// capabilities.
class AppleMLServicesWindow extends StatelessWidget {
  /// Creates a new instance of [AppleMLServicesWindow].
  const AppleMLServicesWindow({
    required this.onServiceTapped,
    super.key,
  });

  /// A function called when one of the badges representing services from Apple ML is tapped.
  final void Function(AppleMachineLearningService) onServiceTapped;

  @override
  Widget build(BuildContext context) {
    return BrutalistContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Inset.xSmall),
            child: Text(
              AppLocalizations.of(context)!.featuresHeader,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: Inset.small,
            thickness: Inset.xxSmall,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              right: Inset.small,
              bottom: Inset.xxSmall,
            ),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.featureItemCount,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: Inset.xSmall,
            thickness: Inset.xxSmall,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: Inset.medium),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(AppleMachineLearningService.values.length, (index) {
              final AppleMachineLearningService service = AppleMachineLearningService.values[index];

              return GestureDetector(
                onTap: () => onServiceTapped(service),
                child: ServiceBadge(
                  imageAsset: service.icon,
                  title: service.getLabel(context),
                ),
              );
            }),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: Inset.large,
            thickness: Inset.xxSmall,
          ),
        ],
      ),
    );
  }
}
