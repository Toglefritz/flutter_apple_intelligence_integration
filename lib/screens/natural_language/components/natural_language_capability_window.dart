import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/screens/natural_language/components/striped_window_header.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// This widget is a simple banner for the section of the app containing demonstrations of the natural language
/// processing features available in the Apple Intelligence Services.
class NaturalLanguageCapabilityWindow extends StatelessWidget {
  /// Creates a new instance of [NaturalLanguageCapabilityWindow].
  const NaturalLanguageCapabilityWindow({
    required this.title,
    required this.content,
    super.key,
  });

  /// The title to display at the top of the window.
  final String title;

  /// The content of the window.
  final Widget content;

  @override
  Widget build(BuildContext context) {
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
  }
}
