import 'package:flutter/material.dart';

void main() {
  runApp(ParentWidget());
}

class ParentWidget extends StatefulWidget {
  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  GlobalKey<_ChildWidgetState> childKey = GlobalKey();
  int childCount = 0;

  void toggleFavorite() {
    setState(() {
      if (favorited) {
        favoriteCount -= 1;
        favorited = false;
      } else {
        favoriteCount += 1;
        favorited = true;
      }
    });
  }

  void getChildData() {
    _ChildWidgetState? childState = childKey.currentState;
    setState(() {
      childCount = childState?.childCount ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('State Test'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('I am Parent, child count : $childCount')
                ),
                ElevatedButton(
                  child: Text('get child data'), onPressed: getChildData)
              ]
            ),
            ChildWidget(key: childKey),
            IconWidget(),
            ContentWidget()
          ],
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  const ChildWidget({super.key});

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  int childCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text('I am Child, $childCount')
        ),
        ElevatedButton(
          child: Text('increment'),
          onPressed: () {
            setState(() {
              childCount++;
            });
          }
        ),
      ],
    );
  }
}

class IconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _ParentWidgetState? state =
      context.findAncestorStateOfType<_ParentWidgetState>();
    return Center(
      child: IconButton(
        icon: ((state?.favorited ?? false)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border)),
        color: Colors.red,
        iconSize: 200,
        onPressed: state?.toggleFavorite,
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _ParentWidgetState? state =
    context.findAncestorStateOfType<_ParentWidgetState>();
    return Center(
      child: Text(
        'favoriteCount : ${state?.favoriteCount}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}


