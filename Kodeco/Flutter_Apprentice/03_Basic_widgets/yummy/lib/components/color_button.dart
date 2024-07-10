import 'package:flutter/material.dart';
import '../constants.dart';

class ColorButton extends StatelessWidget {
  // 필요한 callback과 color로 'ColorButton'을 초기화한다.
  const ColorButton({
    super.key,
    required this.changeColor,
    required this.colorSelected,
  });

  final void Function(int) changeColor; // 색상 선택을 처리하는 콜백
  final ColorSelection colorSelected; // 현재 선택된 색상

  @override
  Widget build(BuildContext context) {
    // 메뉴를 표시하는 팝업 버튼
    return PopupMenuButton(
      icon: Icon(
        Icons.opacity_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      // 둥근 모서리를 적용한다.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // itemBuilder로 메뉴 항목을 생성한다.
      itemBuilder: (context) {
        // ColorSelection으로 색상 옵션 목록을 만든다.
        return List.generate(
          ColorSelection.values.length,
          (index) {
            final currentColor = ColorSelection.values[index];
            // 각 메뉴 항목에 icon과 text를 설정한다다.
            return PopupMenuItem(
              value: index,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.opacity_outlined,
                      color: currentColor.color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(currentColor.label),
                  ),
                ],
              ),
            );
          },
        );
      },
      // 항목이 선택되면 `changeColor`를 호출한다.
      onSelected: changeColor,
    );
  }
}
