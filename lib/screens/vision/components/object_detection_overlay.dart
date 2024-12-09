import 'package:demo_app/services/apple_intelligence_vision/models/object_detection_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/vision_example_image.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A widget that displays an image with object detection bounding boxes and labels.
///
/// Performing object detection on an image results in a list of identified objects, each with a string label and a
/// list of four values representing the bounding box coordinates. This widget overlays the bounding boxes and labels
/// on the input image. This allows easier review of the object detection results visually.
///
/// - [image]: The input image on which the bounding boxes are drawn.
/// - [detections]: A list of object detection results to be overlaid on the image.
class ObjectDetectionOverlay extends StatelessWidget {
  /// Creates an [ObjectDetectionOverlay].
  const ObjectDetectionOverlay({
    required this.image,
    required this.size,
    required this.detections,
    super.key,
  });

  /// The input image on which the bounding boxes are drawn.
  final VisionExampleImage image;

  /// The size of the image.
  final Size size;

  /// A list of object detection results to be overlaid on the image.
  final List<ObjectDetectionResult> detections;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          // Display the input image
          Positioned.fill(
            child: Image.asset(
              image.path,
              width: size.width,
              height: size.height,
            ),
          ),
          // Overlay bounding boxes and labels
          ...detections.map((detection) {
            final List<double> boundingBox = detection.boundingBox;

            return Positioned(
              left: boundingBox[0] * size.width,
              // Invert the y-coordinate because the object detection uses the bottom left corner as the origin
              // rather than the top left corner used by the Stack.
              top: (1.0 - boundingBox[1] - boundingBox[3]) * size.height,
              width: boundingBox[2] * size.width,
              height: boundingBox[3] * size.height,
              child: Stack(
                children: [
                  // Draw the bounding box
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // Display the label
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Inset.xSmall,
                        vertical: Inset.xxSmall,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: Text(
                        detection.identifier,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
