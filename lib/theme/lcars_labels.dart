import 'dart:math';

/// A class for generating LCARS-style random identifiers.
class LCARSLabels {
  /// Generates a random identifier in the format "02-262000".
  ///
  /// - The first character is always '0'.
  /// - The second character is a random digit between 1 and 9 (inclusive).
  /// - The remaining six characters are formed from three random hexadecimal values.
  static String generateRandomIdentifier() {
    final random = Random();

    // The first two characters: '0' followed by a random digit between 1 and 9.
    final firstPart = '0${random.nextInt(9) + 1}';

    // The next six characters: three random hexadecimal values.
    final secondPart = List.generate(3, (_) => random.nextInt(256))
        .map((value) => value.toRadixString(16).padLeft(2, '0'))
        .join();

    return '$firstPart-$secondPart'.toUpperCase();
  }
}
