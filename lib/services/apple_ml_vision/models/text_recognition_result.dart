/// Represents the result of a text recognition operation.
///
/// Each result contains:
/// - [text]: The most confident recognized text for the region.
/// - [candidates]: A list of all recognition candidates for the region, ordered by confidence.
/// - [boundingBox]: The bounding box of the text region as a list of four normalized values:
///   [x, y, width, height], relative to the image size.
class TextRecognitionResult {
  /// The most confident recognized text for the region.
  final String text;

  /// A list of all recognition candidates for the region.
  final List<String> candidates;

  /// The bounding box of the text region as [x, y, width, height].
  final List<double> boundingBox;

  /// Creates a new [TextRecognitionResult].
  const TextRecognitionResult({
    required this.text,
    required this.candidates,
    required this.boundingBox,
  });

  /// Creates a [TextRecognitionResult] from a map.
  factory TextRecognitionResult.fromMap(Map<String, dynamic> map) {
    final List<dynamic> boundingBoxRaw = (map['boundingBox'] as List<dynamic>?) ?? [];
    final List<double> boundingBox = List<double>.from(boundingBoxRaw);

    return TextRecognitionResult(
      text: map['text'] as String,
      candidates: List<String>.from(map['candidates'] as List<dynamic>),
      boundingBox: boundingBox,
    );
  }

  /// Converts the [TextRecognitionResult] to a map.
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'candidates': candidates,
      'boundingBox': boundingBox,
    };
  }
}
