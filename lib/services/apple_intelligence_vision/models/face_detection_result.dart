/// Represents the result of a face detection operation.
///
/// Each result contains:
/// - [boundingBox]: The bounding box of the detected face as a list of four normalized values:
///   - **`x`**: The horizontal position of the bottom-left corner of the bounding box, relative to the image width.
///   - **`y`**: The vertical position of the bottom-left corner of the bounding box, relative to the image height.
///   - **`width`**: The width of the bounding box, as a fraction of the image width.
///   - **`height`**: The height of the bounding box, as a fraction of the image height.
class FaceDetectionResult {
  /// The bounding box of the detected face.
  final List<double> boundingBox;

  /// Creates an instance of [FaceDetectionResult].
  const FaceDetectionResult({required this.boundingBox});

  /// Creates a [FaceDetectionResult] from a map.
  ///
  /// - [map]: A map containing the key `boundingBox`.
  /// - Throws: An exception if the map does not contain the required key or if the bounding box
  ///   is not a list of doubles.
  factory FaceDetectionResult.fromMap(Map<String, dynamic> map) {
    final List<dynamic> boundingBoxRaw = (map['boundingBox'] as List<dynamic>?) ?? [];

    final List<double> boundingBox = List<double>.from(boundingBoxRaw);
    if (boundingBox.length != 4) {
      throw Exception('Bounding box must contain exactly 4 elements.');
    }

    return FaceDetectionResult(boundingBox: boundingBox);
  }

  /// Converts the [FaceDetectionResult] to a map.
  ///
  /// - Returns: A map representation of the result.
  Map<String, dynamic> toMap() {
    return {
      'boundingBox': boundingBox,
    };
  }
}
