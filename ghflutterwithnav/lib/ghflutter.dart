import 'dart:convert'; //Paser

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'memberwidget.dart';
import 'member.dart';
import 'strings.dart';  

class GHFlutterState extends State<GHFlutter> { //GHFlutter를 매개변수로 하는 State 클래스
//State는 Widget이 빌드될 때 동기적으로 해당 Widget의 Life cycle을 변경할 수 있는 정보이다.
//state.setState로 State를 변경하고 알린다.
//일반적으로 StatefulWidget을 생성할 때, StatefulWidget.createState 메서드를 호출해 계층구조에 삽입한다.
//StatefulWidget은 여러 번 생성될 수 있기 때문에 해당 객체에 연결된 State가 여러 개가 될 수도 있다.
//생성 시와 마찬가지로 해제 시에도 State를 변경해 줘야 한다.
  var _members = <Member>[]; //멤버 리스트 
  //Dart 에서는 map 타입이다. Kotlin에서도 Map, Swift에서는 Dictionary와 같다.

  final _biggerFont = const TextStyle(fontSize: 18.0); //텍스트 스타일 속성 //크기, 위치, 렌더링을 결정한다.
  //변수나 상수 앞에 underscore를 사용해 클래스 멤버를 private로 설정할 수 있다.

  @override
  void initState() { //Widget이 계층 구조에 삽입될 때 호출된다. 초기화를 해 줄 수 있다.
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) { //Widget 생성 시 파리미터로 BuildContext가 전달된다.
    //새 Widget을 생성하면, build()를 override한다. 해당 Widet이 screen에 렌더링 될 때 호출된다.
    return new Scaffold( //Scaffold는 material 디자인 Widget의 container이다. 계층 구조의 root 역할을 한다.
      appBar: new AppBar(
        title: new Text(Strings.appTitle),
      ),
      body: new ListView.builder(
        // padding: const EdgeInsets.all(16.0), //패딩을 추가한다. //Divder가 생기면서 제거
        itemCount: _members.length * 2, //row의 수 //Divider를 추가하기 위해 2배로 늘린다.
        itemBuilder: (BuildContext context, int position) { //_buildRow로 각 row를 설정한다.
          //Adding dividers
          if (position.isOdd) return new Divider(); //홀수 이면 Divder 추가
          //Divder는 수평선으로 양쪽에 padding이 있다.

          final index = position ~/ 2; //몫을 정수형으로 가져온다.

          return _buildRow(index);
        }),
        //Using a ListView
        //ListView Widget로 데이터를 리스트에 표시할 수 있다.
        //Android의 RecyclerView, iOS 의 UITableView와 같은 역할을 한다.
    );
  }

  Widget _buildRow(int i) {
    // return new ListTile( //ListView에 사용되는 row (UITableViewCell에 해당한다.)
    //   title: new Text("${_members[i]["login"]}", style: _biggerFont),
    // );

    return new Padding( //각 row에 예전처럼 padding 추가하려면, ListTile에 직접 지정해 줄 수 있다.
      padding: const EdgeInsets.all(16.0), //4방향 모두 offset 한다.
      child: new ListTile(
        title: new Text("${_members[i].login}", style: _biggerFont), //Member class
        leading: new CircleAvatar( //사용자를 표시해 주는 원형 Widget. 프로필 이미지로 주로 사용한다.
          backgroundColor: Colors.green,
          backgroundImage: new NetworkImage(_members[i].avatarUrl), //이미지 추가
          //NetworkImage으로 지정된 url의 이미지를 쉽게 가져올 수 있다. 자동으로 캐시한다.
        ),
        //i번째 멤버의 JSON Parsing한 값에서 login 값을 표시한다.
        //위에서 정의한, text style을 사용한다.

        //Add onTap here:
        onTap: () { _pushMember(_members[i]); }, //Tap gesture 시에 실행된다.
      
      //이제 ListTile은 Padding의 child이다. row에서 padding이 존재하지만, Divider에는 없다.
      ),
    );
  }

  _loadData() async { //async로 비동기 임을 알린다.
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataURL); //await로 비동기를 기다렸다가 가져온다.
    //Making Network Calls
    //import로 패키지를 가져올 수도 있다.
    //Dart는 async/await 패턴을 사용해 UI 스레드를 차단하지 않는 비동키 코드 실행과 다른 스레드에서 코드 실행을 지원한다.

    setState(() { //HTTP 호출이 완료되면, 콜백을 setState()로 전달한다.
      final membersJSON = JsonCodec().decode(response.body); //JSON 디코딩

      for (var memberJSON in membersJSON) {
        final member = new Member(memberJSON["login"], memberJSON["avatar_url"]); //Member 객체
        _members.add(member); //Map에 추가
      }
    });
  }

  _pushMember(Member member) {
    //Routes
    //Flutter의 Navigation은 routes를 중심으로 구성된다.
    //Routes는 REST API의 경로와 비슷하다. 각 경로(route)는 root와 연관되어 있다.
    //main에서 만들어진 widget이 root 역할을 하게 된다.
    //route를 사용하는 방법 중 하나는 PageRoute 클래스를 사용하는 것이다.
    //MaterialApp으로 작업중 이므로, MaterialPageRoute을 사용한다.
    // Navigator.of(context).push ( //state의 context를 가져온다.
    //   //Navigator에서 새로운 MaterialPageRoute를 스택에 push 한다.
    //   //push 스타일도 각 OS에 맞춰진다(Android : 아래에서 위로, iOS 왼쪽에서 오른쪽으로).
    //   new MaterialPageRoute( //화면 전환하는 route
    //     builder: (context) => new MemberWidget(member) //MemberWidget으로 경로를 생성한다.
    //   )
    // );

    //Custom Transitions
    //PageRouteBuilder를 사용해 사용자 정의 전환효과를 추가해 줄 수 있다.
    Navigator.of(context).push(new PageRouteBuilder( //PageRouteBuilder를 Navigation 스택에 넣는다.
      opaque: true,
      transitionDuration: const Duration(milliseconds: 1000), //지속 시간
      pageBuilder: (BuildContext context, _, __) { //화면 생성
        return new MemberWidget(member);
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) { 
        //transitionsBuilder 속성을 지정해 준다. 전환효과를 추가해 줄 수 있다.
        return new FadeTransition( //불투명도 애니메이션
          opacity: animation,
          child: new RotationTransition( //회전 애니메이션
            turns: new Tween<double>(begin: 0.0, end: 1.0).animate(animation), //시작과 끝 값을 지정해 준다.
            child: child,
          ),
        );
      }
    ));
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => new GHFlutterState(); //State 객체를 생성한다.
}




