import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Inherited Test')
        ),
        body: MyInheritedWidget(TestWidget())
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  int count = 0; //하위 공유 데이터..

  MyInheritedWidget(child) : super(child: child);

  static MyInheritedWidget of(BuildContext context) {
    final MyInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
    assert(result != null, 'No MyInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget old) {
    return true;
  }

  increment() {
    //하위에서 호출 할 함수
    count++;
  }
}

class TestSubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = MyInheritedWidget.of(context)!.count;
    return Container(
      width: 200,
      height: 200,
      color: Colors.yellow,
      child: Center(
        child: Text(
          'SubWidget : $count',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        )
      )
    );
  }
}

class TestWidget extends StatelessWidget {
  TestWidget() {
    print('TestWidget constructor..');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          MyInheritedWidget? widget = MyInheritedWidget.of(context);
          int counter = MyInheritedWidget.of(context)!.count;
          Function increment = MyInheritedWidget.of(context)!.increment;
          return Center(
            child: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'TestWidget : $counter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton(
                      child: Text('increment()'),
                      onPressed: () => setState(() => increment())),
                  ElevatedButton(
                      onPressed: () {
                        setState(() => widget!.count++);
                      },
                      child: Text('count++')),
                  TestSubWidget()
                ]
              )
            )
          );
        });
  }
}

