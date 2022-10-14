import 'package:flutter/material.dart';

import 'quiz_brain.dart';

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
  int questionNumber = 0;
  QuizBrain quizBrain = QuizBrain();
  List<AnswerIcon> scoreKeeper = [];

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
                quizBrain.questionsBank[questionNumber].questionText,
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
          onPressed: () => answerQuestion(
            questionAnswer:
                quizBrain.questionsBank[questionNumber].questionAnswer,
          ),
        ),
        AnswerButton(
          label: 'False',
          color: Colors.red,
          onPressed: () => answerQuestion(
            questionAnswer:
                !quizBrain.questionsBank[questionNumber].questionAnswer,
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }

  void answerQuestion({required bool questionAnswer}) {
    setState(() {
      scoreKeeper.add(AnswerIcon(isTrue: questionAnswer));
      questionNumber++;
    });
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
