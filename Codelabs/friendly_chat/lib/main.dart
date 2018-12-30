import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:flutter/cupertino.dart";

const String _name = "Your Name";

final ThemeData kIOSTheme = ThemeData( //iOS 테마
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData( //Android 테마
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

void main() {
  runApp( //Widget을 확장하여 런타임에 앱 화면을 표시한다.
    FriendlychatApp() //Widget Tree의 Root가 된다.
  );
}

class FriendlychatApp extends StatelessWidget { //Root level Widget으로 state가 변하지 않는다.
  @override
  Widget build(BuildContext context) {
    //Widget의 build 메서드는 해당 위젯이 Widget 트리 계층에 삽입되거나 dependency가 변경될 때 호출된다.
    return MaterialApp(
      title: "Friendlychat",
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      //TargetPlatform으로 실행 기기의 플랫폼을 가져올 수 있다.
      home: ChatScreen(), //home은 Default Route를 지정한다.
    );
  }
}




class ChatScreen extends StatefulWidget { //채팅에서 메시지가 보내지고 state가 변하면서 rebuild 된다.
  //StatefulWidget은 여러 상태를 가질 수 있는 위젯이다. state는 위젯이 build될 때 동기적으로 읽을 수 있고 life time 동안 변경될 수 있는 정보이다.
  //Flutter에서 stateful data를 위젯에 시각적으로 표시하려면 데이터를 state에 캡슐화해야 한다. 그 후에 state 객체를 StatefulWidget과 연결해야 한다.

  @override
  State createState() => ChatScreenState(); //StatefulWidget이라면 반드시 createState를 구현해야 한다.
  //state 클래스의 createState() 메서드를 재정의 한다.
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[]; //Chat message 리스트
  final TextEditingController _textController = TextEditingController();
  //TextField와 상호작용을 관리하려면, TextEditingController를 사용하는 것이 좋다.
  //입력 필드의 내용을 읽거나 텍스트 메시지를 처리한 후 필드를 지우는 등의 작업을 처리해 줄 수 있다.
  bool _isComposing = false; //필드에 입력되었는지 여부를 판단하는 변수

  @override
  Widget build(BuildContext context) { //State 객체에서 연결되어 있는 StatefulWidget 위젯트리의 모든 요소를 포함한다.
    //UI를 새로 build해야 하는 경우, state에서 이를 구성해 줄 수 있게 된다.
    //Widget의 build 메서드는 해당 위젯이 Widget 트리 계층에 삽입되거나 dependency가 변경될 때 호출된다.
    return Scaffold( //Scaffold는 기본적인 표준 앱 요소를 제공한다.
      appBar: AppBar(
        title: Text("Friendlychat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        //z-coordinate 좌표. AppBar 아래의 그림자 크기를 조절한다.
        //iOS 기본 UIKit에서는 그림자가 있고, Android에서는 없다.
      ),
      body: Container(
        child: Column( //위젯을 수직으로 배치한다
          children: <Widget>[
            Flexible( //ListView의 부모 위젯으로 수신된 메시지의 목록을 확장해 Column의 높이를 채우고, TextField의 크기를 유지한다.
              //ListView의 메시지가 표시 되는 영역
              child: ListView.builder( //ListView.builder 기본 생성자는 children 인수의 변형을 자동으로 감지하지 않는다.
                padding: EdgeInsets.all(8.0), //텍스트 메시지 주위의 공백
                reverse: true, //반대방향으로 해, 화면의 아래부터 채운다.
                itemBuilder: (_, index) => _messages[index], //각 아이템의 위젯을 생성한다. //underscore는 생략을 나타낸다.
                itemCount: _messages.length, //List의 요소 수
              ),
            ),

            Divider( //수평선
              height: 1.0,
            ),

            Container( //TextField와 submit 아이콘이 있는 영역
              decoration: BoxDecoration( //배경 정의
                color: Theme.of(context).cardColor
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS ? //iOS 일때만
          BoxDecoration( //경계선을 넣어준다.
            border: Border(
              top: BorderSide(
                color: Colors.grey[200],
              ),
            ),
          ): null
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme( //색상, 불투명도, 크기를 조정한다.
      data: IconThemeData( //실제적인 값은 IconThemeData 로 지정해 준다.
        color: Theme.of(context).accentColor //강조색
        //BuildContext는 Widget 트리에서 위젯의 위치에 대한 handle이다. 각 Widget에는 고유한 BuildContext이 있다.
        //이는 StatelessWidget에서는 StatelessWidget.build 에서 반환되고 StatefulWidget에서는 State.build 에서 반환된다.
        //즉, 여기에서는 캡슐화된 State 에 액세스해 BuildContext를 가져온다. DI 하거나 파라미터로 전달할 필요 없다.
      ),
      child: Container( //여러 개의 작은 Widget을 만들고 조합하여 컴포지션을 만들 수 있다.
        margin: EdgeInsets.symmetric(horizontal: 8.0), //수평 여백 추가
        child: Row( //Android Studio에서 해당 Widget에 커서가 있는 상태에서 alt + Enter를 해서 다른 Widget으로 래핑할 수 있다.
          children: <Widget>[
            Flexible( //Flexible로 감싸면, Row가 나머지 공간에 맞춰 textField의 크기를 자동으로 조정한다.
              //Flexible은 Row, Column, Flex 요소에 사용할 수 있다.
              child: TextField( //onChange 콜백은 필드의 텍스트가 변경될 때마다 호출된다.
                controller: _textController, //텍스트 제어
                onChanged: (String text) { //필드의 값이 변경되는 경우 콜백
                  setState(() { //state 변경
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted, //Submit한 경우 콜백
                decoration: InputDecoration.collapsed( //InputDecoration으로 아이콘, placeholder, error text 등을 처리할 수 있다.
                  hintText: "Send a message"
                ),
              ),
            ),

            Container( //Container를 사용하면, 여백 간격을 맞추기 용이하다.
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS ? //iOS
                CupertinoButton(
                  child: Text("Send"),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                )
                : //Android
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                  //함수를 한줄로 표현할 수 있는 경우 =>를 사용할 수 있다.
                  //즉, => expression 는 { return expression; } 와 같다.
                  //_isComposing이 true이면, text를 submit하고, 그렇지 않으면 null
                  //처음 값이 false이므로, 아이콘의 색상이 회색이었다가, 텍스트를 입력하면 색상이 바뀐다.
                )
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    setState(() {
      _isComposing = false; //submit이 되면, flag를 toggle해 준다.
    });

    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700), //700 밀리초 동안 지속된다.
        vsync: this, //Ticker(여기서는 TickerProviderStateMixin)를 구현한 객체가 vsync가 된다.
      ),
    );

    setState(() { //해당 위젯이 변경되었을 때 UI를 rebuild 할 것을 요청한다.
      //setState를 호출하지 않고 직접 state를 변경하면 안된다(rebuild 되지 않는다).
      //StatefulWidget은 수동으로 화면을 다시 로드하지 않고, setState를 호출해 다시 위젯을 다시 그린다(Swift draw 처럼).
      //즉, setState를 호출하면, 위젯은 build 함수를 재호출해 새로 그리면서 해당 클로저의 내용도 반영하게 된다.
      //setState에서는 오직 동기화 작업만 수행해야 한다(Swift에서 UI 변경 시에도 DispatchQueue.main 사용하는 것 처럼).
      //프레임워크가 작업 완료 전에 위젯을 다시 build할 수 있기 때문이다.
      //setState에 변경사항을 직접 넣지 않고, 다른 영역에서 변경한 후 빈 클로저를 실행할 수도 있다.
      //하지만 setState에서 변경사항을 직접 작업해 주는 것이 좋다.
      _messages.insert(0, message); //최근 메시지를 가장 아래에 위치하도록 해야 하므로 insert로 추가한다.
    });

    message.animationController.forward(); //애니메이션 실행
  }

  @override
  void dispose() { //해당 객체(ChatScreenState)가 더 이상 사용되지 않을 때 프레임워크가 해당 메서드를 실행해 리소스를 확보한다.
    //현재 앱에서는 하나의 Screen 만 있으므로 호출되지 않는다.
    for (ChatMessage message in _messages)
      message.animationController.dispose(); //더 이상 애니메이션 컨트롤러가 필요하지 않을 때 dispose 해 준다.

    super.dispose();
  }
}

//Scaffold, AppBar 등의 Widget은 Meterial 라이브러리의 위젯이다. Text는 Flutter 자체의 위젯으로 범용적으로 쓰일 수 있다.

//BreakPoint를 Run> Toggle Line Breakpoint을 이용하거나 line num에서 클릭해서 지정해 줄 수 있다.
//그 후에, Run > Debug에서 디버그 모드로 실행한다.




class ChatMessage extends StatelessWidget { //채팅 메시지 하나를 나타내는 Widget
  //채팅 메시지 자체는 state가 변할 것이 없으므로 StatelessWidget
  ChatMessage({this.text, this.animationController}); //생성자

  final String text;
  final AnimationController animationController;
  //Flutter의 애니메이션은 input value와 status(forward, backward, completed, dismissed...) 가 있는 캡슐화된 Animation으로 구현한다.
  //AnimationController를 생성할 때, vsync 인자를 전달해 줘야 한다. 이는 화면을 벗어난 애니메이션이 불필요한 리소스를 소비하는 것을 막는다.
  //여기서 애니메이션은 ChatMessage에서 발생하므로 ChatScreenState가 아닌 이 객체에 AnimationController를 추가해 준다.

  @override
  Widget build(BuildContext context) {
    return SizeTransition( //크기 변화
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, //crossAxisAlignment은 하위 위젯들의 배치 방향을 지정해 준다.
          //Row가 주축이 수평인 위젯이므로, start를 주면, 수직 축의 가장 위에 위치하게 된다.
          children: <Widget>[ //여러 개의 작은 Widget을 만들고 조합하여 컴포지션을 만들 수 있다.
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar( //원형으로 이미지를 나타내는 위젯. 일반적으로 프로필에 사용한다.
                child: Text(_name[0]),
              ),
            ),

            Expanded( //오버 플로우된 텍스트가 줄바꿈 되도록 하는 간단한 방법은 Expanded 위젯으로 감싸는 것이다.
              //Expanded는 Row, Column, Flex의 하위 위젯이 기본축의 공간을 채우도록 확장한다.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //crossAxisAlignment은 하위 위젯들의 배치 방향을 지정해 준다.
                //Column이 주축이 수직인 위젯이므로, start를 주면, 수평 축의 가장 왼쪽에 위치하게 된다.
                children: <Widget>[
                  Text( //name
                    _name,
                    style: Theme.of(context).textTheme.subhead,
                    //context의 textTheme를 사용해 스타일을 지하면, 텍스트의 속성을 직정 하드코딩할 필요 없다.
                    //이 테마를 재정의하여, Android와 iOS의 스타일을 다르게 지정할 수도 있다.
                  ),

                  Container( //message
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




