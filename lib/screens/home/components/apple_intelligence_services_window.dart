import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/home/components/service_badge.dart';
import 'package:demo_app/values/image_asset.dart';
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalistContainer(
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
            height: 16.0,
            thickness: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceBadge(
                imageAsset: ImageAsset.nlpIcon,
                title: AppLocalizations.of(context)!.nlp.replaceAll(' ', '\n'),
              ),
              ServiceBadge(
                imageAsset: ImageAsset.sound,
                title: AppLocalizations.of(context)!.sound,
              ),
              ServiceBadge(
                imageAsset: ImageAsset.speech,
                title: AppLocalizations.of(context)!.speech,
              ),
              ServiceBadge(
                imageAsset: ImageAsset.translation,
                title: AppLocalizations.of(context)!.translation,
              ),
              ServiceBadge(
                imageAsset: ImageAsset.vision,
                title: AppLocalizations.of(context)!.vision,
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 32.0,
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
