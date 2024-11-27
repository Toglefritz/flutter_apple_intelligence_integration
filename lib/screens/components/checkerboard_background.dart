import 'package:flutter/material.dart';

/// A widget that displays a background grid of alternating black and white squares. Each square is 2px by 2px, with
/// rows offset for a seamless repeating pattern.
class CheckerboardBackground extends StatelessWidget {
  /// Creates an instance of [CheckerboardBackground].
  const CheckerboardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomPaint(
        painter: _CheckerboardPainter(),
        size: Size.infinite,
      ),
    );
  }
}

/// A [CustomPainter] that draws a checkerboard pattern of alternating black and white squares.
class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // The width and height of each square in the grid
    const double squareSize = 2.0;

    // The paint object used to draw the squares
    final Paint paint = Paint();

    // Loop through rows and columns to draw the grid
    for (double y = 0; y < size.height; y += squareSize) {
      for (double x = 0; x < size.width; x += squareSize) {
        // Determine the color based on the row and column offsets
        final bool isBlack = ((x ~/ squareSize) + (y ~/ squareSize)).isEven;
        paint.color = isBlack ? Colors.black : Colors.white54;

        // Draw the square
        canvas.drawRect(
          Rect.fromLTWH(x, y, squareSize, squareSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // This widget is static, so no need to repaint
    return false;
  }
}
