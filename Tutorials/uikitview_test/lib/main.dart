import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Hello, world"),
            SizedBox(
              width: 350,
              height: 350,
              child: UiKitView(viewType: "FlutterView"),
              //UiKitView로, ios Native 코드를 가져올 수 있다.
              //선택한 viewType이 id가 된다.
              //유사하게 AndroidView도 있다.

              //이런 Native 코드를 embeding 하는 것은 리소스를 많이 사용하므로 꼭 필요한 경우에만 사용한다.
            )
          ],
        ),
      ),
    );
  }
}
