import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/body.dart';

void main() {
  runApp(const InsataCloneApp());
}

class InsataCloneApp extends StatelessWidget {
  const InsataCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          secondary: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const InstaCloneHome(),
    );
  }
}

class InstaCloneHome extends StatefulWidget {
  const InstaCloneHome({super.key});

  @override
  State<InstaCloneHome> createState() => _InstaCloneHomeState();
}

class _InstaCloneHomeState extends State<InstaCloneHome> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    // 조건에 따라 보여야 할 때 Visibility로 감쌀 수 있다.
    // 너무 길어 복잡하면 코드를 접어서 관리하는게 좋다. ⌥ + ⌘ + [ or ]
    return Scaffold(
      appBar: index == 0
          ? AppBar(
              title: Text(
                'Instagram',
                style: GoogleFonts.lobsterTwo(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 32,
                  ),
                  onPressed: () {
                    print('Favorite');
                  },
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.paperplane,
                    size: 32,
                  ),
                  onPressed: () {
                    print('Direct');
                  },
                ),
              ],
            )
          : null,
      body: InstaBody(index: index),
      bottomNavigationBar: BottomNavigationBar(
        // 선택된 index를 가져온다.
        currentIndex: index,
        onTap: (newIndex) => setState(
          () {
            index = newIndex;
          },
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 28), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 28), label: 'Search'),
        ],
      ),
    );
  }
}
