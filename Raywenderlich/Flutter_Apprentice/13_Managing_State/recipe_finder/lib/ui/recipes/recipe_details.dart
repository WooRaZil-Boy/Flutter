import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../network/recipe_model.dart';
import '../../data/models/models.dart';
import '../../data/memory_repository.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider를 사용하여 main.dart에 생성된 리포지토리를 검색합니다.
    final repository = Provider.of<MemoryRepository>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    // Comment out Align()
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/pizza_w700.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: CachedNetworkImage(
                    //     imageUrl: recipe.image ?? '',
                    //     alignment: Alignment.topLeft,
                    //     fit: BoxFit.fill,
                    //     width: size.width,
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: shim,
                        ),
                        child: const BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // 변경될 수 있는 recipe.label을 사용하고 있으므로 더 이상 const가 아닙니다.
                // 변경되지 않는 위젯에는 const를 사용합니다.
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    recipe.label ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 변경가능한 값을 가져오므로 더이상 const가 아닙니다.
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
                    label: Text(
                      getCalories(recipe.calories),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    onPressed: () {
                      // Recipe를 Repository에 추가합니다.
                      repository.insertRecipe(recipe);
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icon_bookmark.svg',
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Bookmark',
                      style: TextStyle(color: Colors.white),
                    ),
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
