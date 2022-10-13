import 'package:flutter/material.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: QuizScreen(),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];

  int questionNumber = 0;

  List<AnswerIcon> scoreKeeper = [
    const AnswerIcon(isTrue: true),
    const AnswerIcon(isTrue: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                questions[questionNumber],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
        AnswerButton(
          label: 'True',
          color: Colors.green,
          onPressed: () => setState(() {
            questionNumber++;
            scoreKeeper.add(const AnswerIcon(isTrue: true));
          }),
        ),
        AnswerButton(
          label: 'False',
          color: Colors.red,
          onPressed: () => setState(() {
            questionNumber++;
            scoreKeeper.add(const AnswerIcon(isTrue: false));
          }),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String label;
  final Color color;
  final void Function() onPressed;

  const AnswerButton({
    Key? key,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}

class AnswerIcon extends StatelessWidget {
  final bool isTrue;
  const AnswerIcon({Key? key, required this.isTrue}) : super(key: key);

  @override
  Icon build(BuildContext context) => isTrue
      ? const Icon(
          Icons.check_rounded,
          color: Colors.green,
        )
      : const Icon(
          Icons.close_rounded,
          color: Colors.red,
        );
}
