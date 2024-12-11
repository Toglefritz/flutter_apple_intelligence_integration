/// Represents a single result from an image classification performed by Apple Machine Learning.
///
/// Each result contains:
/// - [identifier]: The label assigned to the image.
/// - [confidence]: The confidence score for the classification.
class ImageClassificationResult {
  /// The label of the classification result (e.g., "Cat").
  final String identifier;

  /// The confidence score for the classification, as a percentage.
  final double confidence;

  /// Creates an instance of [ImageClassificationResult].
  const ImageClassificationResult({
    required this.identifier,
    required this.confidence,
  });

  /// Creates an [ImageClassificationResult] from a map.
  ///
  /// - [map]: A map containing the keys `identifier` and `confidence`.
  /// - Throws: An exception if the map does not contain the required keys.
  factory ImageClassificationResult.fromMap(Map<String, dynamic> map) {
    return ImageClassificationResult(
      identifier: map['identifier'] as String,
      confidence: (map['confidence'] as num).toDouble(),
    );
  }

  /// Converts the [ImageClassificationResult] to a map.
  ///
  /// - Returns: A map representation of the result.
  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'confidence': confidence,
    };
  }
}
