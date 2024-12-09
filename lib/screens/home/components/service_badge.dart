import 'package:demo_app/values/image_asset.dart';
import 'package:flutter/material.dart';

/// A badge displaying an icon for an Apple Intelligence service.
class ServiceBadge extends StatelessWidget {
  /// Creates a new instance of [ServiceBadge].
  const ServiceBadge({
    required this.imageAsset,
    required this.title,
    super.key,
  });

  /// The asset path for the image to display in the badge.
  final ImageAsset imageAsset;

  /// A title for the service displayed below the image.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageAsset.path,
          width: 48,
          height: 48,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
