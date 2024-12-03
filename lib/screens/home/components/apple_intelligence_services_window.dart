import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/home/components/service_badge.dart';
import 'package:demo_app/services/models/apple_intelligence_service.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A container including icons for Apple Intelligence services.
///
/// This widget is a container designed to emulate the appearance of windows in 1980s versions of MacOS. The window
/// includes a series of icons, each corresponding to a different service offered by Apple Intelligence. The window can
/// be dragged to change its position on the screen.
class AppleIntelligencesServicesWindow extends StatelessWidget {
  /// Creates a new instance of [AppleIntelligencesServicesWindow].
  const AppleIntelligencesServicesWindow({
    required this.onServiceTapped,
    super.key,
  });

  /// A function called when one of the badges representing services from Apple Intelligence is tapped.
  final void Function(AppleIntelligenceService) onServiceTapped;

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
            children: List.generate(AppleIntelligenceService.values.length, (index) {
              final AppleIntelligenceService service = AppleIntelligenceService.values[index];

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
