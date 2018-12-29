import "package:flutter/material.dart";
import "package:meta/meta.dart";

import "category.dart";

const _rowHeight = 100.0; //final은 상수. undersocre는 private
final _borderRadius = BorderRadius.circular(_rowHeight / 2);
//const는 컴파일 타임에 결정되는 상수. 사용되지 않더라도 메모리 공간을 차지하게 된다.
//final은 런타임에 결정되는 상수. 한 번만 값을 설정할 수 있으며 액세스 될 때 초기화 되어 메모리 공간을 차지하게 된다(lazy).

class CategoryTile extends StatelessWidget { //Category 리스트를 보여주기 위한 CategoryTile 리스트를 만든다.
  final Category category;
  final ValueChanged<Category> onTap; //ValueChanged은 값이 변경된 후 호출된다.

  const CategoryTile({
    Key key,
    @required this.category,
    this.onTap,
  })  : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap == null ? Color.fromRGBO(50, 50, 50, 0.2) : Colors.transparent, //오류 처리
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: category.color["highlight"],
          splashColor: category.color["splash"],
          onTap: onTap == null ? null : () => onTap(category), //오류 처리
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset(category.iconLocation), 
                  //Image.asset으로 asset의 이미지를 가져올 수 있다.
                ),
                Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
