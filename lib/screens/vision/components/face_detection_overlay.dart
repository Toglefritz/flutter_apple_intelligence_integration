import 'package:demo_app/services/apple_ml_vision/models/face_detection_result.dart';
import 'package:demo_app/services/apple_ml_vision/models/vision_example_image.dart';
import 'package:flutter/material.dart';

/// A widget that displays an image with face detection bounding boxes and labels.
///
/// Performing face detection on an image results in a list of identified faces, each with bounding box coordinates.
/// This widget overlays the bounding boxes on the input image. This allows easier review of the face detection results
/// visually.
///
/// - [image]: The input image on which the bounding boxes are drawn.
/// - [detections]: A list of face detection results to be overlaid on the image.
class FaceDetectionOverlay extends StatelessWidget {
  /// Creates an [FaceDetectionOverlay].
  const FaceDetectionOverlay({
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
  final List<FaceDetectionResult> detections;

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
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
