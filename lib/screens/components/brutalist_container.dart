import 'package:flutter/material.dart';

/// A Flutter widget that displays a container with a black border, square corners, and a solid black shadow offset to
/// the bottom-right.
class BrutalistContainer extends StatelessWidget {
  /// The child contained by the container.
  final Widget child;

  /// Creates an instance of [BrutalistContainer].
  const BrutalistContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2.0,
        ),
        borderRadius: BorderRadius.zero,
        boxShadow: const [
          BoxShadow(
            offset: Offset(3.0, 3.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
