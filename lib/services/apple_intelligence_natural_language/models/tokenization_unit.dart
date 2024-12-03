/// An enumeration representing the possible levels of tokenization.
///
/// Tokenization is the process of breaking text into smaller components. The `TokenizationUnit` enum defines two
/// levels of tokenization supported by this service:
/// - **Word-Level Tokenization**: Breaks the text into individual words.
/// - **Sentence-Level Tokenization**: Breaks the text into complete sentences.
enum TokenizationUnit {
  /// Tokenizes text into individual words.
  ///
  /// In word-level tokenization, each word in the input text becomes a separate token. Punctuation marks are also
  /// treated as separate tokens.
  ///
  /// ### Example:
  /// Input: `"Hello, world!"`
  /// Output: `["Hello", ",", "world", "!"]`
  word,

  /// Tokenizes text into complete sentences.
  ///
  /// In sentence-level tokenization, the input text is divided into sentences. The division is based on punctuation
  /// and context, and each sentence becomes a separate token.
  ///
  /// ### Example:
  /// Input: `"Hello, world! How are you?"`
  /// Output: `["Hello, world!", "How are you?"]`
  sentence,
}
