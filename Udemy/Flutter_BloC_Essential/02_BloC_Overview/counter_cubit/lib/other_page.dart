
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other'),
      ),
      body: Center(
        child: Text(
          'Other',
          style: TextStyle(fontSize: 52.0),
        )
      ),
    );
  }
}