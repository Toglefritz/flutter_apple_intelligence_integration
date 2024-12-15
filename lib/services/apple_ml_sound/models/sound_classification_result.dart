/// Represents a single sound classification result.
///
/// Each result contains:
/// - [identifier]: The name of the detected sound.
/// - [confidence]: The confidence score of the classification, as a double between 0.0 and 1.0.
class SoundClassificationResult {
  /// The name of the detected sound.
  final String identifier;

  /// The confidence score of the classification.
  final double confidence;

  /// Creates an instance of [SoundClassificationResult].
  const SoundClassificationResult({
    required this.identifier,
    required this.confidence,
  });

  /// Creates a [SoundClassificationResult] from a map.
  ///
  /// - [map]: A map containing the keys `identifier` and `confidence`.
  /// - Throws: An exception if the map does not contain the required keys or if the `confidence`
  ///   value is not a double.
  factory SoundClassificationResult.fromMap(Map<String, dynamic> map) {
    return SoundClassificationResult(
      identifier: map['identifier'] as String,
      confidence: (map['confidence'] as num).toDouble(),
    );
  }

  /// Returns the confidence score as a percentage.
  String get confidencePercentage => '${(confidence * 100).toStringAsFixed(2)}%';

  /// Converts the [SoundClassificationResult] to a map.
  ///
  /// - Returns: A map representation of the result.
  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'confidence': confidence,
    };
  }
}
