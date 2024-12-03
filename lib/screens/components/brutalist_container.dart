import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A Flutter widget that displays a container with a black border, square corners, and a solid black shadow offset to
/// the bottom-right.
class BrutalistContainer extends StatelessWidget {
  /// The child contained by the container.
  final Widget child;

  /// Creates an instance of [BrutalistContainer].
  const BrutalistContainer({
    required this.child,
    this.backgroundColor = Colors.white,
    super.key,
  });


  /// The background color of the container.
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: Inset.xxSmall,
        ),
        borderRadius: BorderRadius.zero,
        boxShadow: const [
          BoxShadow(
            offset: Offset(
              Inset.xxSmall,
              Inset.xxSmall,
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
