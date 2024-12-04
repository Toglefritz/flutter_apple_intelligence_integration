import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A button widget styled with brutalist design principles.
///
/// The `BrutalistButton` is based on the `ElevatedButton` widget but with:
/// - No corner radius (square edges).
/// - A solid black shadow with no spread, offset to create a brutalist appearance.
class BrutalistButton extends StatelessWidget {
  /// The function to be called when the button is pressed.
  final VoidCallback? onTap;

  /// The content of the button.
  final String text;

  /// Creates a `BrutalistButton`.
  const BrutalistButton({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
