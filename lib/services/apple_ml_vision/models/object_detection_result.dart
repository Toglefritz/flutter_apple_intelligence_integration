/// Represents the result of an object detection operation.
///
/// This class encapsulates the label and bounding box of an object detected in an image. Each detection includes:
/// - [identifier]: A string that describes the detected object (e.g., "bicycle").
/// - [boundingBox]: A list of four values that define the bounding box for the detected object:
///   1. **`x`**: The normalized horizontal position of the top-left corner of the bounding box, relative to the image width.
///   2. **`y`**: The normalized vertical position of the top-left corner of the bounding box, relative to the image height.
///   3. **`width`**: The normalized width of the bounding box, as a fraction of the image width.
///   4. **`height`**: The normalized height of the bounding box, as a fraction of the image height.
///
/// ## Example Detection Results
///
/// Consider the following object detection results from an example image:
///
/// ```text
/// bicycle ([0.5224609375, 0.12939453125, 0.423828125, 0.37890625]),
/// diningtable ([0.04296875, 0.1866455078125, 0.4091796875, 0.201904296875]),
/// pottedplant ([0.30279541015625, 0.3688812255859375, 0.0701904296875, 0.062042236328125])
/// ```
///
/// - For the **bicycle**, the bounding box starts at approximately 52% of the image width and 13% of the image height.
///   The box spans approximately 42% of the width and 38% of the height.
/// - For the **diningtable**, the bounding box starts near the top-left corner and covers about 41% of the width and
///   20% of the height.
///
/// ## Coordinate System and Transformation
///
/// The bounding box coordinates use a coordinate system where the origin `(0, 0)` is at the **bottom-left** corner
/// of the image. However, many Flutter widgets, such as `Stack`, use a coordinate system with the origin at the
/// **top-left** corner. This difference means that the `y` coordinate and bounding box height need to be transformed
/// for accurate placement on a Flutter widget:
///
/// ```dart
/// final double transformedY = 1.0 - boundingBox[1] - boundingBox[3];
/// ```
///
/// This transformation adjusts the `y` coordinate to match Flutter's coordinate system and ensures the bounding box
/// is displayed correctly when overlaying it on the image.
///
/// ## Usage
///
/// The `ObjectDetectionResult` class provides helper methods to create an instance from a map (e.g., results returned
/// from a Method Channel) and to convert the instance back to a map for serialization.
///
/// ```dart
/// final detection = ObjectDetectionResult.fromMap({
///   'object': 'bicycle',
///   'boundingBox': [0.52, 0.13, 0.42, 0.38],
/// });
/// print(detection.identifier); // Outputs: bicycle
/// print(detection.boundingBox); // Outputs: [0.52, 0.13, 0.42, 0.38]
/// ```
class ObjectDetectionResult {
  /// The label of the detected object.
  final String identifier;

  /// The bounding box of the detected object.
  final List<double> boundingBox;

  /// Creates an instance of [ObjectDetectionResult].
  const ObjectDetectionResult({
    required this.identifier,
    required this.boundingBox,
  });

  /// Creates an [ObjectDetectionResult] from a map.
  ///
  /// - [map]: A map containing the keys `identifier` and `boundingBox`.
  /// - Throws: An exception if the map does not contain the required keys or if the bounding box
  ///   is not a list of doubles.
  factory ObjectDetectionResult.fromMap(Map<String, dynamic> map) {
    final List<dynamic> boundingBoxRaw = (map['boundingBox'] as List<dynamic>?) ?? [];

    final List<double> boundingBox = List<double>.from(boundingBoxRaw).toList();
    if (boundingBox.length != 4) {
      throw Exception('Bounding box must contain exactly 4 elements.');
    }

    return ObjectDetectionResult(
      identifier: map['object'] as String,
      boundingBox: boundingBox,
    );
  }

  /// Converts the [ObjectDetectionResult] to a map.
  ///
  /// - Returns: A map representation of the result.
  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'boundingBox': boundingBox,
    };
  }
}
