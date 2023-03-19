import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Test'
          ),
        ),
        body: Column(
          children: [
            Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
            ),
            Container(
              color: Colors.red,
              child: Image.asset(
                'images/big.jpeg',
                width: 200,
                height: 100,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
