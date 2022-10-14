class Question {
  final String _questionText;
  final bool _questionAnswer;

  Question(
    this._questionText,
    this._questionAnswer,
  );

  String get questionText => _questionText;
  bool get questionAnswer => _questionAnswer;
}
