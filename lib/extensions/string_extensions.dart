/// Contains extension methods for the [String] class.
extension StringExtensions on String? {
  /// Capitalizes the first letter of the string.
  String? capitalize() {
    if (this == null) return null;
    if (this!.isEmpty) return this;

    return this!.substring(0, 1).toUpperCase() + this!.substring(1);
  }
}
