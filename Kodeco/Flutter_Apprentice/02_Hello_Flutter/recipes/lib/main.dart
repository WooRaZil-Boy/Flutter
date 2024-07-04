import 'package:flutter/material.dart';
import 'recipe.dart'; // Recipe 클래스를 가져온다.
import 'recipe_detail.dart';

// main()은 앱이 실행될 때 코드의 시작점이다. runApp()은 앱의 최상위 위젯을 Flutter에 알려준다.
void main() {
  runApp(const RecipesApp());
}

// Flutter에서는 사용자 인터페이스를 구성하는 거의 모든 것이 Widget이다.
// StatelessWidget은 빌드한 후에 변경되지 않는다.
class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  // 위젯의 build() 메서드는 다른 위젯을 함께 구성하여 새 위젯을 만들기 위한 시작점이다.
  // @override 어노테이션은 이 메서드가 StatelessWidget의 기본 메서드를 대체해야 한다는 것을 Dart 분석기에 알려준다.
  @override
  Widget build(BuildContext context) {
    // theme는 색상과 같은 시각적 측면을 결정한다. 기본 ThemeData는 표준 머티리얼 기본값을 표시한다.
    final ThemeData theme = ThemeData();

    // MaterialApp은 머티리얼 디자인을 사용하며 RecipesApp에 포함될 위젯이다.
    return MaterialApp(
      // title은 기기에서 앱을 식별하는 데 사용된다. UI에는 표시되지 않는다.
      title: 'Recipe Calculator',
      // theme를 복사하고 colorScheme를 수정하면 앱의 색이 변경된다.
      // 여기서는 fromSeed 생성자를 사용하여, ThemeData가 머티리얼 디자인에 따라 위젯의 스타일을 지정하는 데 사용하는 음영과 톤을 생성한다.
      theme: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
        ),
      ),
      // title을 업데이트하여 기기에 표시한다.
      home: const MyHomePage(
        title: 'Recipe Calculator',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold는 화면의 상위 레벨 구조를 제공한다.
    // 여기서는 두 개의 프로퍼티(appBar, body)를 사용하고 있다.
    return Scaffold(
      // AppBar는 이전의 home: MyHomePage(title: 'Recipe Calculator')에서 전달된 title 속성으로 Text 위젯을 생성한다.
      // AppBar와 같은 일부 위젯은 사용자 정의 appearance 속성을 받을 수도 있다.
      // Flutter의 toolkit으로 생성된 템플릿 프로젝트에서 AppBar는 _MyHomePageState에서 backgroundColor가 inversePrimary로 설정되어 있다.
      // 이 경우 AppBar의 색상을 변경하는 사용자 지정 appearance은 적용되지 않는다.
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // 노치, 하단의 홈 표시기 등 대화형 영역과 같은 운영 체제 인터페이스 공간을 피하기 위한 SafeArea가 있다.
      body: SafeArea(
        // ListView를 사용하여 목록을 생성한다.
        child: ListView.builder(
          // itemCount는 목록에 있는 행의 수를 결정한다.
          // 여기서 length는 Recipe.samples 목록에 있는 객체의 수이다.
          itemCount: Recipe.samples.length,
          // itemBuilder는 각 행에 대한 위젯 트리를 빌드한다.
          itemBuilder: (BuildContext context, int index) {
            // GestureDetector으로 제스처를 감지한다.
            return GestureDetector(
              // 위젯을 탭할 때 호출되는 콜백인 onTap() 함수를 구현한다.
              onTap: () {
                // Navigator 위젯은 Page Stack 을 관리한다. 
                // MaterialPageRoute로 push()를 호출하면 새로운 Material Page가 스택에 푸시된다.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder로 이동될 page 위젯을 생성한다.
                    builder: (context) {
                      return RecipeDetail(recipe: Recipe.samples[index]);
                    },
                  ),
                );
              },
              // Text 위젯으로 레시피의 이름을 표시한다.
              // return Text(Recipe.samples[index].label);
              // child는 GestureDetector로 제스처가 활성화된 영역을 정의한다.
              child: buildRecipeCard(
                Recipe.samples[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

// buildRecipeCard()함수로 Card widget을 반환한다.
// Card는 머티리얼 디자인의 표준적인 방법으로 정보를 표시하는 데 사용된다.
// Card는 위젯 하단의 기본값이 둥근 사각형이다. 머티리얼 디자인은 기본적인 corner radius와 shadow를 제공한다.
Widget buildRecipeCard(Recipe recipe) {
  return Card(
    // elevation은 Card의 높이를 결정하여 그림자 깊이에 영향을 준다.
    elevation: 2.0,
    // shape로 Card 모양을 지정한다. 여기서는 corner radius이 10.0인 둥근 직사각형을 정의한다.
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // 지정된 padding 값만큼 자식에 여백을 삽입한다.
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      // Column은 자식 위젯을 세로로 배열한다.
      child: Column(
        // Column에는 Image, Text 두 개의 widget children이 있다.
        children: <Widget>[
          Image(
            // AssetImage는 pubspec.yaml에 정의된 로컬 assets 번들에서 이미지를 가져온다.
            image: AssetImage(recipe.imageUrl),
          ),
          // Image와 Text 사이에 SizedBox를 추가한다. 크기가 고정된 빈 위젯이다.
          const SizedBox(
            height: 14.0,
          ),
          // recipe.label로 Text 위젯을 생성한다.
          Text(
            recipe.label,
            // style로 Text 위젯을 지정한다. 여기서는 크기가 20.0이고 굵기가 w700인 Palatino 글꼴을 지정한다.
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'Palatino',
            ),
          ),
        ],
      ),
    ),
  );
}

// RecipeApp > MaterialApp > MyHomePage > Scaffold > AppBar, ListView > Card의 위젯트리를 가진다.
// 해당 다이어그램을 확인해 보기 위해서는 Flutter Inspector를 사용하면 된다.
// Flutter Inspector는 앱의 위젯 트리를 시각적으로 표시하고, 위젯의 속성을 검사하고, 위젯의 상태를 변경할 수 있는 도구이다.
// 위젯을 선택하면 명시적으로 설정한 위젯과 기본적으로 상속되거나 설정된 위젯을 포함한 모든 실시간 속성이 별도의 창에 표시된다.
// Inspector에서 위젯을 선택하면 소스에서 위젯이 정의된 위치도 강조 표시된다.
// 여기서 스크롤하면, 카드의 수가 변경되는 것을 알 수 있다. 이는 성능을 위해 ListView.builder가 동적으로 레시피 목록을 생성하기 때문이다.
// 즉, 모든 항목을 한 번에 메모리에 저장하지 않고, 필요할 때 로드한다.
