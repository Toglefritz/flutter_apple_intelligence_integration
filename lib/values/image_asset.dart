/// An enumeration of image assets used in the app.
enum ImageAsset {
  /// A 2D, black and white glyph version of the app icon.
  appIcon('assets/apple_intelligence.png'),

  /// A generic back arrow icon.
  arrowIcon('assets/arrow_icon.png'),

  /// An icon used for the Apple Intelligence natural language processing service.
  nlpIcon('assets/nlp.png'),

  /// An icon used for the Apple Intelligence sound service.
  sound('assets/sound.png'),

  /// An icon used for the Apple Intelligence speech recognition service.
  speech('assets/speech.png'),

  /// An icon used for the Apple Intelligence translation service.
  translation('assets/translation.png'),

  /// An icon used for the Apple Intelligence vision service.
  vision('assets/vision.png'),;

  /// The path to the image asset.
  final String path;

  /// Creates a new instance of [ImageAsset].
  const ImageAsset(this.path);
}
