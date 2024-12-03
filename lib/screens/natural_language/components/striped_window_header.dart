import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A header for a "window" container that includes a striped pattern.
///
/// This widget is a simple header for a "window" container that includes a striped pattern. The window widget is one
/// designed to look like a window in 1980s versions of MacOS. The header includes a title for the window. Behind the
/// title, the header includes a striped pattern to give the appearance of a window header.
class StripedWindowHeader extends StatelessWidget {
  /// Creates a new instance of [StripedWindowHeader].
  const StripedWindowHeader({
    required this.title,
    this.isFancy = false,
    super.key,
  });

  /// The text to display within the window header.
  final String title;

  /// Determines the visual complexity of the header. If true, five stripes are displayed along with a white square
  /// on the left side of the window. Otherwise, a simpler design is used, featuring only three stripes.
  final bool isFancy;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Draw simple stripes
        if (!isFancy) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: Inset.small),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: Inset.xxSmall,
            thickness: Inset.xxSmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Inset.small),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
        ],

        // Draw fancy stripes
        if (isFancy) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: Inset.xSmall),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: Inset.small),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: Inset.xxSmall,
            thickness: Inset.xxSmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Inset.small),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Inset.xSmall),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.xxSmall,
              thickness: Inset.xxSmall,
            ),
          ),
          Positioned(
            left: Inset.small,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: Inset.xxSmall,
                ),
                color: Theme.of(context).primaryColorLight,
              ),
              width: Inset.small,
              height: Inset.small,
            ),
          ),
        ],

        ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Inset.small,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
