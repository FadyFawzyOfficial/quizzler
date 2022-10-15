import 'package:flutter/material.dart';
// COMPLETED: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';
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
                quizBrain.questionText,
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
          onPressed: () => checkAnswer(userPickedAnswer: true),
        ),
        AnswerButton(
          label: 'False',
          color: Colors.red,
          onPressed: () => checkAnswer(userPickedAnswer: false),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }

  void checkAnswer({required bool userPickedAnswer}) {
    setState(() {
      // COMPLETED: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if (quizBrain.isFinished) {
        // COMPLETED: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        // HINT! Step 4 Part B is in the quiz_brain.dart
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        // COMPLETED: Step 4 Part C - reset the questionNumber,
        quizBrain.reset();
        // COMPLETED: Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper.clear();
      } else {
        // COMPLETED: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
        scoreKeeper.add(
          AnswerIcon(
            isCorrectAnswer: userPickedAnswer == quizBrain.questionAnswer,
          ),
        );
        quizBrain.getNextQuestion();
      }
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
  final bool isCorrectAnswer;
  const AnswerIcon({Key? key, required this.isCorrectAnswer}) : super(key: key);

  @override
  Icon build(BuildContext context) => isCorrectAnswer
      ? const Icon(
          Icons.check_rounded,
          color: Colors.green,
        )
      : const Icon(
          Icons.close_rounded,
          color: Colors.red,
        );
}
