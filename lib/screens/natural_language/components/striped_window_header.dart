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
    required this.title, super.key,
  });

  /// The text to display within the window header.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
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
