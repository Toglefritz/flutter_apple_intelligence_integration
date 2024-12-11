import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/natural_language/components/striped_window_header.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// An enumeration of possible display formats for this widget.
enum CapabilityWindowDisplayFormat {
  /// A window consisting of a header with three stripes and a white background.
  striped,

  /// A window consisting of a header with five stripes with a square on the left side and a white background.
  fancy,

  /// A window consisting of a plain header and a grey background.
  plain,
}

/// A "window" that displays an interface for the demonstration of an Apple Machine Learning capability.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// title at the top, a content area, and a footer. The content area is where the user interacts with the capability.
///
/// Different display formats are available for the window. The [CapabilityWindowDisplayFormat.striped] format includes
/// a header with three stripes and a white background. The [CapabilityWindowDisplayFormat.fancy] format includes a header
/// with five stripes with a square on the left side and a white background. The [CapabilityWindowDisplayFormat.plain]
/// format includes a plain header and a grey background.
///
/// The content area is provided as a [Widget] to the [CapabilityWindow] constructor. This allows any generic content to
/// be displayed in the window.
class CapabilityWindow extends StatelessWidget {
  /// Creates a new instance of [CapabilityWindow].
  const CapabilityWindow({
    required this.displayFormat,
    required this.title,
    required this.content,
    super.key,
  });

  /// The display style of the window.
  final CapabilityWindowDisplayFormat displayFormat;

  /// The title to display at the top of the window.
  final String title;

  /// The content of the window.
  final Widget content;

  @override
  Widget build(BuildContext context) {
    if (displayFormat == CapabilityWindowDisplayFormat.striped) {
      return BrutalistContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Inset.xSmall),
              child: StripedWindowHeader(
                title: title,
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.medium,
              thickness: Inset.xxSmall,
            ),

            // Field for collecting text for which the language will be identified
            content,

            Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.large,
              thickness: Inset.xxSmall,
            ),
          ],
        ),
      );
    } else if (displayFormat == CapabilityWindowDisplayFormat.plain) {
      return BrutalistContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Inset.xSmall),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.medium,
              thickness: Inset.xxSmall,
            ),

            // Field for collecting text for which the language will be identified
            content,

            Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.large,
              thickness: Inset.xxSmall,
            ),
          ],
        ),
      );
    } else {
      return BrutalistContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Inset.xSmall),
              child: StripedWindowHeader(
                title: title,
                isFancy: true,
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.medium,
              thickness: Inset.xxSmall,
            ),

            // Field for collecting text for which the language will be identified
            content,

            Divider(
              color: Theme.of(context).primaryColor,
              height: Inset.large,
              thickness: Inset.xxSmall,
            ),
          ],
        ),
      );
    }
  }
}
