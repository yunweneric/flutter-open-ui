class Word {
  final String title;
  final bool hasLearned;

  Word({required this.title, required this.hasLearned});

  Word copyWith({
    String? title,
    bool? hasLearned,
  }) {
    return Word(
      title: title ?? this.title,
      hasLearned: hasLearned ?? this.hasLearned,
    );
  }
}
