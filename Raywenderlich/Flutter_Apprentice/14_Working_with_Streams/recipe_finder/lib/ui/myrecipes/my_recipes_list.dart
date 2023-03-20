import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../data/models/recipe.dart';
import '../../data/repository.dart';

class MyRecipesList extends StatefulWidget {
  const MyRecipesList({Key? key}) : super(key: key);

  @override
  State createState() => _MyRecipesListState();
}

class _MyRecipesListState extends State<MyRecipesList> {
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    // Provider를 사용하여 Repository를 가져옵니다.
    final repository = Provider.of<Repository>(context, listen: false);

    // List<Recipe> 스트림 유형을 사용하는 StreamBuilder를 사용합니다.
    return StreamBuilder<List<Recipe>>(
      // watchAllRecipes()를 사용하여 빌더가 사용할 레시피 스트림을 반환합니다.
      stream: repository.watchAllRecipes(),
      // 빌더 콜백을 사용하여 스냅샷을 수신합니다.
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        // 연결 상태를 확인합니다. 상태가 active이면 데이터가 있는 것입니다.
        if (snapshot.connectionState == ConnectionState.active) {
          final recipes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              final recipe = recipes[index];
              return SizedBox(
                height: 100,
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        label: 'Delete',
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                        onPressed: (context) {
                          deleteRecipe(
                            repository,
                            recipe,
                          );
                        },
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        label: 'Delete',
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                        onPressed: (context) {
                          deleteRecipe(
                            repository,
                            recipe,
                          );
                        },
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: recipe.image ?? '',
                            height: 120,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(recipe.label ?? ''),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // 스냅샷이 준비되지 않은 경우 컨테이너를 반환합니다.
          return Container();
        }
      },
    );
  }

  void deleteRecipe(Repository repository, Recipe recipe) async {
    repository.deleteRecipe(recipe);
    setState(() {});
  }
}
