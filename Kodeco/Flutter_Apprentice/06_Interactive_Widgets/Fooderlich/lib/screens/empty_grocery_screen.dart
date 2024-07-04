import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Padding: 모든 면에 30픽셀을 추가합니다.
    return Padding(
      padding: const EdgeInsets.all(30.0),
      // Center: 다른 모든 위젯을 중앙에 배치합니다.
      child: Center(
        // Column: 다른 위젯의 세로 레이아웃을 처리합니다.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible은 자식에 주축의 사용 가능한 공간을 채울 수 있는 기능을 제공합니다.
            Flexible(
              // AspectRatio는 지정된 aspectRatio로 자식의 크기를 조정합니다.
              // aspectRatio은 double이지만 Flutter 문서에서는 계산된 결과 대신 width / height로 작성할 것을 권장합니다. 이 경우 1.0이 아닌 1 / 1의 정사각형 종횡비를 원합니다.
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              )
            ),
            Text(
              'No Groceries',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Shopping for ingredients?\n'
                  'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              color: Colors.green,
              onPressed: () {
                // Provider.of()를 사용하여 모델 객체 TabManager에 액세스하고,
                // goToRecipes()는 인덱스를 Recipes 탭으로 설정합니다.
                // 이렇게 하면 올바른 탭 인덱스로 홈을 다시 빌드하도록 Consumer에게 알립니다.
                Provider.of<TabManager>(context, listen: false).goToRecipes();
              },
              child: const Text('Browse Recipes')
            )
          ],
        ),
      ),
    );
  }
}
