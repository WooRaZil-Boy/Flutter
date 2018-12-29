import 'package:flutter/material.dart'; //Material Deisign : Android

import 'member.dart';

class MemberState extends State<MemberWidget> {
  final Member member;

  MemberState(this.member); //생성자

  @override
  Widget build(BuildContext context) { //모든 위젯은 build를 구현해야 한다.
    return new Scaffold( //Scaffold는 root역할을 하는 container
      appBar: new AppBar(
        title: new Text(member.login),
      ),
      body: new Padding( //패딩 추가
        padding: new EdgeInsets.all(16.0),
        child: new Column( //Image를 대체한다. //Column은 스크롤 되지 않는다. //Column 하나로만 구성된 뷰가 된다.
          children: [
            new Image.network(member.avatarUrl), //네트워크로 이미지를 가져온다.
            new IconButton( //아이콘 버튼을 생성한다. UIButton처럼 기본값이 설정되어 있다. 
              //IconButton은 부모가 Material 위젯이거나 상속해야 한다.
              icon: new Icon(Icons.arrow_back, color: Colors.green, size: 48.0), //기본으로 제공되는 아이콘
              //아이콘을 생성하며, 아이콘 내용과 색상은 Enum처럼 가져와 사용한다.
              //https://docs.flutter.io/flutter/material/Icons-class.html
              onPressed: () { Navigator.pop(context); } //누르면 pop 해서 이전으로 돌아간다.
            ),
            new RaisedButton( //Material Design의 Raise Button
              child: new Text("PRESS ME"),
              onPressed: () { _showOKScreen(context); } //누를 때 함수 실행
            )
          ]),
        // new Image.network(member.avatarUrl), //네트워크에서 이미지를 가져온다. //Column으로 대체된다.
      )
    );
  }

  _showOKScreen(BuildContext context) async { //비동기
    bool value = await Navigator.of(context).push(new MaterialPageRoute<bool>( 
      //await로 비동기를 기다렸다가 가져온다. pop 될때까지 기다린다.
      //bool 값을 가지는 MaterialPageRoute를 생성한다. 사용자의 제스처에 따른 bool 값으로 행동을 지정해 줄 수 있다.
      builder: (BuildContext context) {
        return new Padding(
          padding: const EdgeInsets.all(32.0),
          child: new Column(
            children: [
              new GestureDetector( //제스처를 감지한다.
                child: new Text("OK"),
                onTap: () { Navigator.of(context).pop(true); }, //탭 하면, true를 전달하며 pop
              ), 
              new GestureDetector( //제스처를 감지한다.
                child: new Text("NOT OK"),
                onTap: () { Navigator.of(context).pop(false); }, //탭 하면, false를 전달하며 pop
              )
            ]
          ),
        );
      }
    ));

    var alert = new AlertDialog( //alert 생성
      content: new Text((value != null && value) ? "OK was pressed" : "NOT OK or Back was pressed"),
      //뒤로 가기 버튼을 누르면 null이 된다.
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK"),
          onPressed: () { Navigator.of(context).pop(); }, //버튼을 누르면, alert이 사라진다.
          //alert이 stack 밖으로 pop되어야 사라진다.
        )
      ],
    );

    showDialog(context: context, child: alert);
  }
}

class MemberWidget extends StatefulWidget {
  final Member member;

  MemberWidget(this.member) { //생성자
    if (member == null) {
      throw new ArgumentError("member of MemberWidget cannot be null. "
          "Received: '$member'"); //null이면 Error를 throw 한다.
    }
  }

  @override
  createState() => new MemberState(member); //변경 가능한 State를 트리의 지정된 위치에 작성한다.
  //일반적으로 StatefulWidget을 생성할 때, StatefulWidget.createState 메서드를 호출해 계층구조에 삽입한다.
  //MemberWidget의 상태로 MemberState를 사용한다.
}