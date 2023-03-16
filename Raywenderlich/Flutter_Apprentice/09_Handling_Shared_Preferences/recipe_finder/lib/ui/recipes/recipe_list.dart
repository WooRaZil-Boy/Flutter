import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_dropdown.dart';
import '../colors.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  // 각 검색어에 고유한 키를 부여합니다.
  // 모든 환경설정은 고유 키를 사용해야 하며, 그렇지 않으면 덮어쓰게 됩니다.
  // 여기서는 환경설정 키에 대한 상수를 정의하기만 하면 됩니다.
  static const String prefSearchKey = 'previousSearches';
  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];
  // TODO: Add _currentRecipes1

  @override
  void initState() {
    super.initState();
    // TODO: Call loadRecipes()

    // 앱을 시작할 때 이전 검색이 모두 로드됩니다.
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

  // TODO: Add loadRecipes

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  // async 키워드를 사용하여 이 메서드가 비동기적으로 실행됨을 나타냅니다.
  void savePreviousSearches() async {
    // await 키워드를 사용하여 SharedPreferences의 인스턴스를 기다립니다.
    final prefs = await SharedPreferences.getInstance();
    // prefSearchKey 키를 사용하여 이전 검색 목록을 저장합니다.
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  // 이 메서드도 비동기입니다.
  void getPreviousSearches() async {
    // await 키워드를 사용하여 SharedPreferences의 인스턴스를 기다립니다.
    final prefs = await SharedPreferences.getInstance();
    // 저장된 목록에 대한 환경설정이 이미 존재하는지 확인합니다.
    if (prefs.containsKey(prefSearchKey)) {
      // 이전 검색 목록을 가져옵니다.
      final searches = prefs.getStringList(prefSearchKey);
      // 목록이 null이 아니라면 이전 검색을 설정하고, 그렇지 않으면 빈 목록을 초기화합니다.
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
            //  아이콘이 사용자가 탭하여 검색을 수행할 수 있는 IconButton으로 대체됩니다.
            IconButton(
              icon: const Icon(Icons.search),
              // 탭 이벤트를 처리하기 위해 onPressed을 추가합니다.
              onPressed: () {
                // 현재 검색 텍스트를 사용하여 검색을 시작합니다.
                startSearch(searchTextController.text);
                // FocusScope 클래스를 사용하여 키보드를 숨깁니다.
                final currentFocus = FocusScope.of(context);
                if(!currentFocus.hasPrimaryFocus) {
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
                    // 검색어를 입력할 TextField를 추가합니다.
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Search'
                      ),
                      autofocus: false,
                      // 키보드 동작을 TextInputAction.done으로 설정합니다.
                      // 이렇게 하면 사용자가 Done 버튼을 누르면 키보드가 닫힙니다.
                      textInputAction: TextInputAction.done,
                      // 사용자가 텍스트 입력을 완료하면 검색을 시작합니다.
                      onSubmitted: (value) {
                        startSearch(searchTextController.text);
                      },
                      controller: searchTextController,
                    ),
                  ),
                  // 이전 검색을 표시하는 PopupMenuButton을 만듭니다.
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: lightGrey,
                    ),
                    // 사용자가 이전 검색에서 항목을 선택하면 새 검색을 시작합니다.
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      // 이전 검색을 표시할 사용자 지정 드롭다운 메뉴 목록을 작성합니다
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                         return CustomDropdownMenuItem<String>(
                           text: value,
                           value: value,
                           callback: () {
                             setState(() {
                               // X 아이콘을 누르면 이전 검색에서 해당 검색을 삭제하고 팝업 메뉴를 닫습니다.
                               previousSearches.remove(value);
                               savePreviousSearches();
                               Navigator.pop(context);
                             });
                           },
                         );
                      }).toList();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    // setState()를 호출하여 시스템에 위젯을 다시 그리도록 지시합니다.
    setState(() {
      // 현재 검색 목록을 지우고 개수, 시작 및 끝 위치를 재설정합니다.
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();

      // 검색 텍스트가 이전 검색 목록에 이미 추가되지 않았는지 확인합니다.
      if (!previousSearches.contains(value)) {
        // 검색 항목을 이전 검색 목록에 추가합니다.
        previousSearches.add(value);
        // 이전 검색의 새 목록을 저장합니다.
        savePreviousSearches();
      }
    });
  }

  // TODO: Replace method
  Widget _buildRecipeLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    // Show a loading indicator while waiting for the movies
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // TODO: Add _buildRecipeCard
}
