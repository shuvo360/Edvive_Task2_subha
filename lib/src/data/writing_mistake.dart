class WritingMistake {
  final int offset;

  final int length;

  final String issueType;

  final String issueDescription;

  final String message;

  final List<String> replacements;

  WritingMistake({
    required this.message,
    required this.offset,
    required this.length,
    required this.issueType,
    required this.issueDescription,
    required this.replacements,
  });

  WritingMistake copyWith({
    required int offset,
    required int length,
    required String issueType,
    required String issueDescription,
    String? message,
    List<String>? replacements,
  }) {
    return WritingMistake(
      offset: offset ?? this.offset,
      length: length ?? this.length,
      issueType: issueType ?? issueType,
      issueDescription: issueDescription ?? issueDescription,
      message: message ?? this.message,
      replacements: replacements ?? this.replacements,
    );
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'WritingMistake(offset: $offset, length: $length, issueType: $issueType, issueDescription: $issueDescription, message: $message, replacements: $replacements)';
  }
}
