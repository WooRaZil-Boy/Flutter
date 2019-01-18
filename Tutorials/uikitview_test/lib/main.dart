import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "image_actions.dart";

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
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int imageIndex = 0;
  final ImageActions imageActions = ImageActions();

  @override
  void initState() {
    super.initState();

    imageActions.init(this);
  }

  Future<void> _getImageIndex() async {
    int result = await imageActions.getImageIndex();

    setState(() {
      imageIndex = result;
    });
  }

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
            RaisedButton(
              child: Text("Get Image Index"),
              onPressed: _getImageIndex,
            ),
            Text("image Index :: $imageIndex"),
            SizedBox(
              width: 350,
              height: 350,
              child: GestureDetector(
                onTap: () {
                  _getImageIndex();
                  print("TAP :: $imageIndex");

                },
                child: UiKitView(
                  viewType: "FlutterView",
                ),
                //UiKitView로, ios Native 코드를 가져올 수 있다.
                //선택한 viewType이 id가 된다.
                //유사하게 AndroidView도 있다.

                //이런 Native 코드를 embeding 하는 것은 리소스를 많이 사용하므로 꼭 필요한 경우에만 사용한다.
              )



              // child: UiKitView(
              //   viewType: "FlutterView",
              //   ),
            )
          ],
        ),
      ),
    );
  }
}
