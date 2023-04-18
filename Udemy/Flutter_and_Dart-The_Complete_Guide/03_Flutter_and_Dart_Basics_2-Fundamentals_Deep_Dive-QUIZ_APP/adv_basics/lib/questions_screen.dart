import 'package:flutter/material.dart';

// 상태를 관리해야 하기 때문에 StatefulWidget을 사용해야 한다.
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('QuestionsScreen');
  }
}