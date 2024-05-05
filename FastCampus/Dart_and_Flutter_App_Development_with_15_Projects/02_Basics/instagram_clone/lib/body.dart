import 'package:flutter/material.dart';
import 'package:instagram_clone/screen/home_screen.dart';
import 'package:instagram_clone/screen/search_screen.dart';

class InstaBody extends StatelessWidget {
  const InstaBody({super.key, required this.index});

  final int index; // enum을 사용하는 것이 더 나은 구현이다.

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const HomeScreen();
    }

    return const SearchScreen();
  }
}