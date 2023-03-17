import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../network/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';
import '../recipe_card.dart';
import '../widgets/custom_dropdown.dart';
import 'recipe_details.dart';
import '../../network/recipe_service.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();

  List<APIHits> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();

    getPreviousSearches();
    searchTextController = TextEditingController(text: '');
    _scrollController
      .addListener(() {
        final triggerFetchMoreSize =
            0.7 * _scrollController.position.maxScrollExtent;

        if (_scrollController.position.pixels > triggerFetchMoreSize) {
          if (hasMore &&
              currentEndPosition < currentCount &&
              !loading &&
              !inErrorState) {
            setState(() {
              loading = true;
              currentStartPosition = currentEndPosition;
              currentEndPosition =
                  min(currentStartPosition + pageCount, currentCount);
            });
          }
        }
      });
  }

  // 이 메서드는 비동기식이며 Future를 반환합니다.
  Future<APIRecipeQuery> getRecipeData(String query, int from, int to) async {
    // getRecipes()가 완료된 후 결과를 저장하는 recipeJson을 정의합니다.
    final recipeJson = await RecipeService().getRecipes(query, from, to);
    // recipeMap 변수는 Dart의 json.decode()를 사용하여 문자열을
    // Map<String, dynamic> 유형의 맵으로 디코딩합니다.
    final recipeMap = json.decode(recipeJson);
    return APIRecipeQuery.fromJson(recipeMap);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildRecipeLoader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Search'),
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      startSearch(searchTextController.text);
                    },
                    controller: searchTextController,
                  )),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: lightGrey,
                    ),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                        return CustomDropdownMenuItem<String>(
                          text: value,
                          value: value,
                          callback: () {
                            setState(() {
                              previousSearches.remove(value);
                              savePreviousSearches();
                              Navigator.pop(context);
                            });
                          },
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();
      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Widget _buildRecipeLoader(BuildContext context) {
    // 검색어에 최소 세 글자 이상이 있는지 확인합니다.
    // 이 값을 변경할 수 있지만 한두 개의 문자만으로는 좋은 결과를 얻지 못할 수 있습니다.
    if (searchTextController.text.length < 3) {
      return Container();
    }

    // FutureBuilder는 APIRecipeQuery가 반환하는 Future의 현재 상태를 결정합니다.
    // 그런 다음 로드하는 동안 비동기 데이터를 표시하는 위젯을 빌드합니다.
    return FutureBuilder<APIRecipeQuery>(
      // getRecipeData()가 반환하는 Future를 future에 할당합니다.
      future: getRecipeData(
        searchTextController.text.trim(),
        currentStartPosition,
        currentEndPosition
      ),
      // builder가 필요하며 위젯을 반환합니다.
      builder: (context, snapshot) {
        // connectionState를 확인합니다. 상태가 done되면 결과 또는 오류로 UI를 업데이트할 수 있습니다.
        if (snapshot.connectionState == ConnectionState.done) {
          // 오류가 있으면 오류 메시지를 표시하는 간단한 Text 엘리먼트를 반환합니다.
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          // 오류가 없으면 쿼리 결과를 처리하고 query.hits를 currentSearchList에 추가합니다.
          loading = false;
          final query = snapshot.data;
          inErrorState = false;

          if(query != null) {
            currentCount = query.count;
            hasMore = query.more;
            currentSearchList.addAll(query.hits);

            // 데이터의 끝에 있지 않다면, currentEndPosition을 현재 위치로 설정합니다.
            if (query.to < currentEndPosition) {
              currentEndPosition = query.to;
            }
          }
          // currentSearchList를 사용하여 _buildRecipeList()를 반환합니다.
          return _buildRecipeList(context, currentSearchList);
          // snapshot.connectionState가 완료되지 않았는지 확인합니다.
        } else {
          // 현재 카운트가 0이면 진행률 표시기를 표시합니다.
          if (currentCount == 0) {
            // Show a loading indicator while waiting for the recipes
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // 그렇지 않으면 현재 목록만 표시합니다.
            return _buildRecipeList(context, currentSearchList);
          }
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext recipeListContext, List<APIHits> hits) {
    // MediaQuery를 사용하여 기기의 화면 크기를 가져옵니다.
    // 그런 다음 고정 항목 높이를 설정하고 너비가 장치 너비의 절반인 카드 열 두 개를 만듭니다.
    final size = MediaQuery.of(context).size;
    const itemHeight = 310;
    final itemWidth = size.width / 2;
    // 너비와 높이가 유연한 Flexible 위젯을 반환합니다.
    return Flexible(
      // 항목 수를 알기 때문에 GridView.builder()를 사용하고 itemBuilder를 사용합니다.
      child: GridView.builder(
        // 스크롤이 아래쪽에서 약 70%에 도달할 때를 감지하기 위해
        // initState()에서 생성된 _scrollController를 사용합니다.
        controller: _scrollController,
        // SliverGridDelegateWithFixedCrossAxisCount 델리게이트는
        // 두 개의 열을 가지며 가로 세로 비율을 설정합니다.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        // 그리드 항목의 길이는 hits 목록의 항목 수에 따라 달라집니다.
        itemCount: hits.length,
        // _buildRecipeCard()를 사용하여 각 레시피에 대한 카드를 반환합니다.
        itemBuilder: (BuildContext context, int index) {
          return _buildRecipeCard(recipeListContext, hits, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(
      BuildContext topLevelContext, List<APIHits> hits, int index) {
    final recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            return const RecipeDetails();
          },
        ));
      },
      child: recipeCard(recipe),
    );
  }
}
