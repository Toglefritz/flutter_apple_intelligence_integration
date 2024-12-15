import 'package:demo_app/values/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// An enumeration of services offered as part of the Apple Machine Learning suite.
enum AppleMachineLearningService {
  /// The natural language processing service.
  naturalLanguageProcessing(ImageAsset.nlpIcon),

  /// The sound service.
  sound(ImageAsset.sound),

  /// The vision service.
  vision(ImageAsset.vision);

  /// An icon representing the service.
  final ImageAsset icon;

  /// Creates a new instance of [AppleMachineLearningService].
  const AppleMachineLearningService(this.icon);

  /// Returns a label to be used for the service in the UI.
  String getLabel(BuildContext context) {
    switch (this) {
      case AppleMachineLearningService.naturalLanguageProcessing:
        return AppLocalizations.of(context)!.nlp.replaceAll(' ', '\n');
      case AppleMachineLearningService.sound:
        return AppLocalizations.of(context)!.sound;
      case AppleMachineLearningService.vision:
        return AppLocalizations.of(context)!.vision;
    }
  }
}
