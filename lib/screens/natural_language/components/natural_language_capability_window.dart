import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/natural_language/components/striped_window_header.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// An enumeration of possible display formats for this widget.
enum NaturalLanguageCapabilityWindowDisplayFormat {
  /// A window consisting of a header with three stripes and a white background.
  striped,

  /// A window consisting of a header with five stripes with a square on the left side and a white background.
  fancy,

  /// A window consisting of a plain header and a grey background.
  plain,
}

/// This widget is a simple banner for the section of the app containing demonstrations of the natural language
/// processing features available in the Apple Intelligence Services.
class NaturalLanguageCapabilityWindow extends StatelessWidget {
  /// Creates a new instance of [NaturalLanguageCapabilityWindow].
  const NaturalLanguageCapabilityWindow({
    required this.displayFormat,
    required this.title,
    required this.content,
    super.key,
  });

  /// The display style of the window.
  final NaturalLanguageCapabilityWindowDisplayFormat displayFormat;

  /// The title to display at the top of the window.
  final String title;

  /// The content of the window.
  final Widget content;

  @override
  Widget build(BuildContext context) {
    if (displayFormat == NaturalLanguageCapabilityWindowDisplayFormat.striped) {
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
    } else if (displayFormat == NaturalLanguageCapabilityWindowDisplayFormat.plain) {
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
