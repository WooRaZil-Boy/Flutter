import "package:flutter/material.dart"; //Material은 웹과 모바일의 표준적인 디자인
import "package:english_words/english_words.dart";

void main() => runApp(MyApp()); //한 줄로 끝나는 함수나 메서드의 경우, => 로 표기할 수 있다.

class MyApp extends StatelessWidget { //StatelessWidget은 정렬, 패딩, 레이아웃까지 거의 모든 것이 위젯이다.
  //위젯은 build()를 호출하여 해당 위젯과 하위 위젯을 표현하는 방법을 설정한다.
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: "Welcome to Flutter",
//      home: Scaffold( //Material 라이브러리의 Scaffold 는 홈 화면의 app bar, title, body를 구성하는 위젯트리
//        appBar: AppBar(
//          title: Text("Welcome to Flutter"),
//        ),
//        body: Center( //Center 위젯은 하위 트리를 화면 가운데로 맞춘다.
//          child: RandomWords(),
//        ),
//      ),
//    );

    return MaterialApp(
      title: "Startup Name Generator",
      theme: ThemeData( //ThemeData를 사용하여 응용 프로그램의 테마를 쉽게 변경할 수 있다.
        primaryColor: Colors.white 
      ),
      home: RandomWords(), //StatefulWidget
    );
  }
}




//StatelessWidget 은 상태가 변할 수 없으므로 모든 값은 최종적인 상수 값이 된다.
//StatefulWidget 은 상태를 변경할 수 있으며, 이를 구현하기 위해서는 최소 2개의 클래스가 필요하다.
//  : 인스턴스를 생성하는 StatefulWidget 클래스와 상태를 가지고 있는 State 클래스
//StatefulWidget 자체는 변경 불가능하지만, State이 위젯의 Lifetime 동안 지속된다.
class RandomWordsState extends State<RandomWords> { //StatefulWidget인 RandomWords 클래스의 State
  //앱의 로직과 상태는 대부분 이곳(State를 상속한 해당 클래스)에서 작성된다.
  //여기서는 사용자가 스크롤 할 때마다 단어 쌍을 생성하고, 하트 아이콘을 토글하여 즐겨찾기 단어 쌍을 추가하거나 제거할 때 이 클래스가 사용된다.
  final _suggestions = <WordPair>[]; //단어 리스트
  final _saved = Set<WordPair>(); //즐겨찾기 단어 리스트
  final _biggerFont = const TextStyle(fontSize: 18.0); //글꼴
  //undersocre로 변수나 상수를 선언하면, private가 된다.

  @override
  Widget build(BuildContext context) { //위젯 생성시 호출된다.
//    final wordPair = WordPair.random();
//    return Text(wordPair.asPascalCase); //PascalCase는 upper camel case라고도 하며, 문자열의 각 단어가 대문자로 시작한다.
    return Scaffold( //Material 라이브러리의 Scaffold 는 홈 화면의 app bar, title, body를 구성하는 위젯트리
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: [ //위젯은 child로 단일 하위 속성을 가지고, children은 다중 속성을 가진다. 이때는 []로 배열을 지정해 준다.
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() { //ListView를 추가해 주는 메서드
    //스크롤하면, 무한 스크롤 ListView를 보여준다.
    return ListView.builder( //ListView의 builder factory를 사용하면, ListView가 lazy로 생성된다.
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) { //callback 클로저로 생각하면 된다. BuildContext과 iterator 가 파라미터로 전달된다.
        //iterator는 0부터 시작하여 호출될 때마다 하나씩 증가한다. 이 모델을 사용하면, 무한 스크롤을 구성할 수 있다.

        if (i.isOdd) return Divider(); //홀수 행에서는 Divider()를 추가

        final index = i ~/ 2; // ~/ 표현식은 나눗셈의 몫을 반환한다(%와 반대).
        //Dart에서는 int / int 를 해도 나머지가 있으면 Double 형으로 몫과 소수를 더한 표현이 반환된다.

        if (index >= _suggestions.length) { //인덱스가 리스트 count 보다 크거나 작다면
          _suggestions.addAll(generateWordPairs().take(10)); //무한 스크롤 구현을 위해 10개를 추가해 준다.
          //처음 앱을 시작 할때 _suggestions.length가 0 이므로 10 개의 wordPairs가 생성되며 시작된다.
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair); //즐겨찾기에 추가되었는 지 확인

    return ListTile( //ListView를 구성하는 ListTile 생성
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon( //trailing으로 title 뒤에 오는 위젯을 추가해 줄 수 있다. 반대로 leading도 존
        alreadySaved ? Icons.favorite : Icons.favorite_border, //삼항 연산자. 즐겨찾기 여부에 따라 아이콘을 다르게
        color: alreadySaved ? Colors.red : null, //삼항 연산자. 즐겨찾기 여부에 따라 아이콘 색을 다르게
      ),
      onTap: () { //해당 아이템이 tap 될 때 callback
        setState(() { //setState는 프레임워크에 state가 변했다는 것을 알린다.
          //setState를 호출하면, Flutter는 화면을 다시 그리게 된다.
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      //새로운 페이지(Flutter에서는 Route라고 한다)를 이동하는 네비게이터는 각 경로가 포함된 Stack을 관리한다.
      //Stack에서 push하게 되면 해당 route로 이동하고 화면이 업데이트된다. pop하면 이전 route로 이동하면서 화면이 업데이트 된다.
      MaterialPageRoute( //전체화면 전환 //fullscreenDialog 속성을 true로 하면 iOS에서는 present 와 같이 위 아래로 새 route가 올라온다.
        builder: (BuildContext context) { //새 route는 builder로 생성한다.
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) { //즐겨찾기로 추가된 단어들을 ListTile로 반환
              //Iterable은 순차적으로 액세스할 수 있는 요소들의 모음으로 Python의 반복자와 비슷하다.
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            });

          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

          return Scaffold( //Scaffold를 반환한다.
            appBar: AppBar(
              title: const Text("Saved Suggestions"),
            ),
            body: ListView( //새 route의 body는 ListTiles 행을 포함하는 ListView가 된다.
              children: divided, //각 행은 구분선이 있다.
            ),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState(); //State를 생성해 준다.
}





