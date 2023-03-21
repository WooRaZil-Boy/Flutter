import 'package:do_it/ch14_1_navigation/one_screen.dart';
import 'package:do_it/ch14_1_navigation/two_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isDeepLink = true;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Test',
      home: Navigator(
        pages: [
          MaterialPage(child: OneScreen()),
          if (_isDeepLink) MaterialPage(child: TwoScreen())
        ],
        onPopPage: (route,result) => route.didPop(result)
      ),
    );
  }
}

class OneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OneScreen'),
      ),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'OneScreen',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TwoScreen'),
      ),
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TwoScreen',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Pop'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
