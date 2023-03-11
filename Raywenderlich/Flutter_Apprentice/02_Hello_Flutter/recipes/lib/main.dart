import 'package:flutter/material.dart';
import 'recipe.dart';
import 'recipe_detail.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  // build() 메서드는 다른 위젯을 함께 구성하여 새 위젯을 만들기 위한 시작점입니다.
  // @override 어노테이션은 이 메서드가 StatelessWidget의 기본 메서드를 대체해야 한다는 것을 Dart 분석기에 알려줍니다.
  @override
  Widget build(BuildContext context) {
    // 테마는 색상과 같은 시각적 측면을 결정합니다. 기본 ThemeData는 표준 머티리얼 기본값을 표시합니다.
    final ThemeData theme = ThemeData();

    // MaterialApp은 머티리얼 디자인을 사용하며 RecipeApp에 포함될 위젯입니다.
    return MaterialApp(
      // 앱 제목은 기기에서 앱을 식별하는 데 사용하는 설명입니다. UI에는 표시되지 않습니다.
      title: 'Recipe Calculator',
      // 테마를 복사하고 색 구성표를 업데이트된 사본으로 바꾸면 앱의 색상을 변경할 수 있습니다.
      // 여기서 기본 색상은 Colors.grey이고 보조 색상은 Colors.black입니다.
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.grey,
          secondary: Colors.black,
        ),
      ),
      // 이전과 동일한 MyHomePage 위젯을 사용하지만 이제 제목을 업데이트하여 장치에 표시합니다.
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold는 화면의 상위 레벨 구조를 제공합니다. 이 경우 두 개의 프로퍼티를 사용하고 있습니다.
    return Scaffold(
      // AppBar는 이전 단계에서 작업한
      // home: MyHomePage(title: 'Recipe Calculator')에서 전달된 title 속성이 있는 Text 위젯을 가져옵니다.
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body에는 앱이 노치나 일부 iOS 화면 하단의 홈 표시기와 같은 대화형 영역과 같은 운영 체제 인터페이스에
      // 너무 가까이 다가가지 않도록 하는 SafeArea가 있습니다.
      body: SafeArea(
        // ListView를 사용하여 목록을 작성합니다.
        child: ListView.builder(
          // itemCount는 목록에 있는 행의 수를 결정합니다.
          // 이 경우 length는 Recipe.samples 목록에 있는 객체의 수입니다.
          itemCount: Recipe.samples.length,
          // itemBuilder는 각 행에 대한 위젯 트리를 빌드합니다
          itemBuilder: (BuildContext context, int index) {
            // 제스처를 감지하는 GestureDetector 위젯을 도입합니다.
            return GestureDetector(
              onTap: () {
                // Navigator 위젯은 페이지 스택을 관리합니다.
                // MaterialPageRoute로 push()를 호출하면 새 머티리얼 페이지가 스택에 푸시됩니다.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder는 대상 페이지 위젯을 생성합니다.
                    builder: (context) {
                      return RecipeDetail(recipe: Recipe.samples[index]);
                    }
                  )
                );
              },
              // GestureDetector의 하위 위젯은 제스처가 활성화된 영역을 정의합니다.
              child: buildRecipeCard(Recipe.samples[index]),
            );
          }
        ),
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    // buildRecipeCard()에서 Card를 반환합니다.
    return Card(
      // 카드의 elevation는 카드가 화면에서 얼마나 높은지를 결정하여 그림자에 영향을 줍니다.
      elevation: 2.0,
      // shape은 카드의 모양을 처리합니다.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      // Card의 자식 속성은 Column입니다. Column은 세로 레이아웃을 정의하는 위젯입니다.
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Column에는 두 개의 children이 있습니다.
          children: <Widget>[
            // 첫 번째 자식은 Image 위젯입니다.
            // AssetImage는 pubspec.yaml에 정의된 로컬 asset 번들에서 이미지를 가져온다고 명시합니다.
            Image(image: AssetImage(recipe.imageUrl)),
            // 이미지와 텍스트 사이에는 SizedBox가 있습니다. 이것은 크기가 고정된 빈 뷰입니다.
            const SizedBox(height: 14.0),
            // Text 위젯은 두 번째 자식입니다. 여기에는 recipe.label 값이 포함됩니다.
            Text(
              recipe.label,
              // style 개체를 사용하여 Text 위젯을 사용자 지정할 수 있습니다.
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino'
              ),
            )
          ],
        ),
      )
    );
  }
}
