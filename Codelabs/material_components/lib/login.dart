// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import 'colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { //State에서 UI에 위젯이 생성되는 방법을 제어한다.
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  //TextEditingController는 텍스트 필드의 값을 제어할 수 있다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( //자식 위젯을 삽입할 때 OS가 영역을 침범하는 것을 방지하기 위해 패딩을 자동으로 넣은 위젯
        //ex. 상단 상태 표시줄 만큼의 들여쓴다. 아이폰 X 등의 독특한 유형의 디바이스에 일정 부분 공간을 준다.
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0), //빈 박스

            // [Name]
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
//                  filled: true, //터치 나 탭 시에, 텍스트 필드의 배경을 채워 영역을 표시해 준다.
                  labelText: "Username",
                ),
              ),
            ),
            // spacer
            SizedBox(height: 12.0),
            // [Password]
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
//                  filled: true,
                  labelText: "Password",
                ),
                obscureText: true, //편집 중인 텍스트를 숨긴다(비밀번호 보호).
              ),
            ),
            ButtonBar( //버튼을 가로로 배치한다.
              children: <Widget>[
                FlatButton(
                  child: Text("CANCEL"),
                  shape: BeveledRectangleBorder( //모양을 지정해 줄 수 있다.
                    //cancel 버튼은 하얀색이라 지정해도 보이지 않지만, 리플 애니메이션 효과에 적용된다.
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                    //TextEditingController.clear 로 연결되어 있는 TextField를 지울 수 있다.
                  },
                ),
                RaisedButton(
                  child: Text("NEXT"),
                  elevation: 8.0, //RaisedButton의 기본 elevation은 2 이다. 값을 올리면 음영이 더 생긴다.
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    //Navigator는 iOS의 UINavigationController와 같이 route stack을 유지 관리한다.
                    //push로 route를 상단에 배치하고, pop으로 상단의 route를 제거한다.
                  },
                )
              ],
            ),
            //여러 버튼들 중에 하나를 선택하는 경우 행동을 유도하는 하나의 버튼에 강조를 해 주는 것이 좋다.
          ],
        ),
      ),
    );
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key); //생성자

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}