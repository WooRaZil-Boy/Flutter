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
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart'; //비대칭 레이아웃

//class HomePage extends StatelessWidget {
//
//  List<Card> _buildGridCards(BuildContext context) { //카드를 생성하는 메서드 //underscore는 private를 의미한다.
//    List<Product> products = ProductsRepository.loadProducts(Category.all);
//
//    if (products == null || products.isEmpty) {
//      return const <Card>[];
//    }
//
//    final ThemeData theme = Theme.of(context); //https://material.io/design/typography/#
//    final NumberFormat formatter = NumberFormat.simpleCurrency( //Number를 통화로 포맷 변환
//        locale: Localizations.localeOf(context).toString()
//    );
//
//    return products.map((product) {
//      return Card(
//        //카드는 하나의 주제에 내용과 작업을 표시하는 독립적인 요소이다. 비슷한 내용을 Collection으로 표현할 수 있다.
//        //카드 위젯을 캡슐화해서 표현해 주는 것이 좋다.
//        clipBehavior: Clip.antiAlias, //옵션에 따라 clipping 된다.
//        elevation: 0.0, //음영 제거
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center, //crossAxis 정렬 방향
//          children: <Widget>[
//            AspectRatio( //특정 비율로 크기를 조정한다. 여기서는 이미지의 비율을 고정시킨다.
//              aspectRatio: 18.0 / 11.0, //비율
//              child: Image.asset(
//                product.assetName,
//                package: product.assetPackage,
//                fit: BoxFit.fitWidth, //가로로 꽉 차게 이미지 주위의 여분의 공간을 채워 공백을 제거한다.
//              ),
//            ),
//            Expanded( //오버 플로우된 텍스트가 줄바꿈 되도록 하는 간단한 방법은 Expanded 위젯으로 감싸는 것이다.
//              //Expanded는 Row, Column, Flex의 하위 위젯이 기본축의 공간을 채우도록 확장한다.
//              child: Padding(
//                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0), //left, top, right, bottom
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      product == null ? "" : product.name,
//                      style: theme.textTheme.button,
//                      softWrap: false, //줄바꿈 시에 softWrap
//                      overflow: TextOverflow.ellipsis, //오버 플로우 처리
//                      maxLines: 1,
//                    ),
//                    SizedBox(height: 4.0),
//                    Text(
//                      product == null ? "" : formatter.format(product.price),
//                      style: theme.textTheme.body2,
//                    ),
//                  ],
//                ),
//              ),
//            )
//          ],
//        ),
//      );
//    }).toList(); //List로 만든다.
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold( //Scaffold는 drawer, snack bar, bottom sheet 등의 구성 요소를 편하게 표시할 수 있다.
//      appBar: AppBar( //iOS의 Navigation Bar에 해당한다.
//        brightness: Brightness.light,
//        leading: IconButton( //image icon을 사용하는 버튼
//          icon: Icon(
//            Icons.menu, //이 아이콘을 햄버거라고도 한다.
//            semanticLabel: "menu",
//          ),
//          onPressed: () {
//            print("Menu button");
//          },
//        ),
//        title: Text("SHRINE"), //AppBar의 title에서 플랫폼 별로 차이가 있다.
//        //iOS는 title이 AppBar의 중앙에 위치하지만(UIKit의 기본), Android는 왼쪽으로 정렬된다.
//        actions: <Widget>[ //leading과 반대로 trailing에 위치하는 버튼들을 actions이라고 한다.
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              semanticLabel: "search",
//              //Icon 클래스의 SemanticLabel 필드는 Flutter에서 접근성을 추가하는 일반적인 방법으로 UI에 표시되지는 않는다.
//              //VoiceOver 같은 특수 목적의 앱에 정보를 전달하는 역할을 한다.
//              //UIAccessibility의 accessibilityLabel와 매우 유사하다.
//              //SemanticLabel 필드가 따로 없는 위젯의 경우에는 Semantics 위젯으로 감싸면 된다.
//            ),
//            onPressed: () {
//              print("Search button");
//            },
//          ),
//          IconButton(
//            icon: Icon(
//              Icons.tune,
//              semanticLabel: "filter",
//            ),
//            onPressed: () {
//              print("Filter button");
//            },
//          ),
//        ],
//      ),
//      body: GridView.count( //count 생성자로 유한한 수의 카드를 생성해준다(infinite도 가능하다).
//        //기본적으로 GridView는 모두 같은 크기의 타일을 생성한다.
//        crossAxisCount: 2, //2개의 column
//        //Flutter에서 crossAxis는 스크롤 되지 않는 축을 의미한다. 스크롤이 되는 축은 mainAxis이다.
//        padding: EdgeInsets.all(16.0), //패딩 지정
//        childAspectRatio: 8.0 / 9.0, //자식 위젯의 mainAxis에 대한 crossAxis의 비율
//        //하위 위젯의 width는 다음과 같이 계산한다.
//        // ([width of the entire grid] - [left padding] - [right padding]) / number of columns
//        // 여기서는 ([width of the entire grid] - 16 - 16) / 2 이 된다.
//        //하위 위젯의 height는 width에서 ratio를 적용해 계산한다.
//        // ([width of the entire grid] - 16 - 16) / 2 * 9 / 8
//        children: _buildGridCards(context)
//      ),
//    );
//  }
//}




//비대칭 레이아웃으로 변경한다.
class HomePage extends StatelessWidget {
  final Category category;

  const HomePage({this.category: Category.all});

  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        brightness: Brightness.light, //AppBar의 밝기를 조정한다. 시간, 네트워크 등의 status 색이 바뀐다.
//        leading: IconButton(
//          icon: Icon(Icons.menu),
//          onPressed: () {
//            print('Menu button');
//          },
//        ),
//        title: Text('SHRINE'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {
//              print('Search button');
//            },
//          ),
//          IconButton(
//            icon: Icon(Icons.tune),
//            onPressed: () {
//              print('Filter button');
//            },
//          ),
//        ],
//      ),
//      body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all)),
//    );

    return AsymmetricView(products: ProductsRepository.loadProducts(category));
  }
}