/// Represents a single result of Named Entity Recognition (NER).
///
/// Each instance of this class contains information about a recognized entity
/// and its corresponding type.
///
/// ### Properties:
/// - [entity]: The identified entity as a string (e.g., `"John"`, `"Apple"`).
/// - [type]: The type of the entity (e.g., `"PersonalName"`, `"OrganizationName"`).
///
/// ### Example:
/// ```dart
/// final result = NamedEntityRecognitionResult(
///   entity: "John",
///   type: "PersonalName",
/// );
/// print("Entity: ${result.entity}, Type: ${result.type}");
/// ```
///
/// This class is intended for use with the `recognizeEntities` function of
/// the `AppleMLNaturalLanguageService` to process and represent NER results.
class NamedEntityRecognitionResult {
  /// The identified entity.
  final String entity;

  /// The type of the identified entity.
  final String type;

  /// Creates an instance of [NamedEntityRecognitionResult].
  const NamedEntityRecognitionResult({
    required this.entity,
    required this.type,
  });

  /// Creates an instance of [NamedEntityRecognitionResult] from a map.
  ///
  /// - [map]: A map containing the keys `entity` and `type`.
  /// - Throws: An exception if the required keys are missing.
  factory NamedEntityRecognitionResult.fromMap(Map<String, String> map) {
    if (!map.containsKey('entity') || !map.containsKey('type')) {
      throw Exception('Invalid map format for NamedEntityRecognitionResult');
    }

    return NamedEntityRecognitionResult(
      entity: map['entity']!,
      type: map['type']!,
    );
  }

  /// Converts the instance to a map.
  ///
  /// - Returns: A map representation of the result.
  Map<String, String> toMap() {
    return {
      'entity': entity,
      'type': type,
    };
  }
}
