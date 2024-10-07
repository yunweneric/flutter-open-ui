class BasuuWord {
  final String title;
  final bool hasLearned;

  BasuuWord({required this.title, required this.hasLearned});

  BasuuWord copyWith({
    String? title,
    bool? hasLearned,
  }) {
    return BasuuWord(
      title: title ?? this.title,
      hasLearned: hasLearned ?? this.hasLearned,
    );
  }
}
