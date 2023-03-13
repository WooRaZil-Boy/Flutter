import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/grocery_item.dart';

class GroceryTile extends StatelessWidget {
  // GroceryTile을 초기화할 때 항목을 확인하여 사용자가 완료로 표시했는지 확인합니다.
  // 그렇다면 텍스트에 strike을 표시합니다. 그렇지 않으면 텍스트를 정상적으로 표시합니다.
  GroceryTile({
    super.key,
    required this.item,
    this.onComplete,
  }) : textDecoration =
  item.isComplete ? TextDecoration.lineThrough : TextDecoration.none;

  final GroceryItem item;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    // Container()는 SizedBox()보다 더 많은 처리가 필요합니다.
    // 상자의 높이만 정의하면 되는 경우에는 SizedBox()만 사용해도 됩니다.
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // 항목의 색상이 있는 컨테이너 위젯을 추가합니다. 이렇게 하면 항목에 색상을 지정하는 데 도움이 됩니다.
              Container(
                width: 5.0,
                color: item.color
              ),
              const SizedBox(width: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.lato(
                      decoration: textDecoration,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 4.0),
                  buildDate(),
                  const SizedBox(height: 4.0),
                  buildImportance()
                ],
              )
            ],
          ),
          Row(
            children: [
              Text(
                item.quantity.toString(),
                style: GoogleFonts.lato(
                  decoration: textDecoration,
                  fontSize: 21.0
                )
              ),
              buildCheckbox()
            ],
          )
        ]
      ),
    );
  }

  // 헬퍼 메서드로 항목의 importance를 확인하고 올바른 Text를 표시합니다.
  Widget buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
        'Low',
        style: GoogleFonts.lato(decoration: textDecoration)
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        'Medium',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w800,
          decoration: textDecoration
        )
      );
    } else if (item.importance == Importance.high) {
      return Text(
        'High',
        style: GoogleFonts.lato(
          color: Colors.red,
          fontWeight: FontWeight.w900,
          decoration: textDecoration
        )
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(
      // item.isComplete에 따라 체크박스를 켜거나 끕니다.
      value: item.isComplete,
      // 사용자가 체크박스를 탭하면 onComplete 콜백을 트리거합니다.
      onChanged: onComplete,
    );
  }
}
