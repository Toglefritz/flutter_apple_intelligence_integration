import 'package:demo_app/values/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// An enumeration of services offered as part of the Apple Intelligence suite.
enum AppleIntelligenceService {
  /// The natural language processing service.
  naturalLanguageProcessing(ImageAsset.nlpIcon),

  /// The sound service.
  sound(ImageAsset.sound),

  /// The speech recognition service.
  speechRecognition(ImageAsset.speech),

  /// The translation service.
  translation(ImageAsset.translation),

  /// The vision service.
  vision(ImageAsset.vision);

  /// An icon representing the service.
  final ImageAsset icon;

  /// Creates a new instance of [AppleIntelligenceService].
  const AppleIntelligenceService(this.icon);

  /// Returns a label to be used for the service in the UI.
  String getLabel(BuildContext context) {
    switch (this) {
      case AppleIntelligenceService.naturalLanguageProcessing:
        return AppLocalizations.of(context)!.nlp.replaceAll(' ', '\n');
      case AppleIntelligenceService.sound:
        return AppLocalizations.of(context)!.sound;
      case AppleIntelligenceService.speechRecognition:
        return AppLocalizations.of(context)!.speech;
      case AppleIntelligenceService.translation:
        return AppLocalizations.of(context)!.translation;
      case AppleIntelligenceService.vision:
        return AppLocalizations.of(context)!.vision;
    }
  }
}
