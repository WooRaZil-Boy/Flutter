import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/screen/dialog/d_message.dart';
import 'package:fast_app_base/screen/main/tab/home/w_bank_account.dart';
import 'package:fast_app_base/screen/main/tab/home/w_rive_like_button.dart';
import 'package:fast_app_base/screen/main/tab/home/w_ttoss_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:live_background/object/palette.dart';
import 'package:live_background/widget/live_background_widget.dart';

import '../../../../common/widget/w_big_button.dart';
import '../../../dialog/d_color_bottom.dart';
import '../../../dialog/d_confirm.dart';
import '../../s_main.dart';
import 'bank_accounts_dummy.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  // 실제로는 상태관리를 해야 한다.
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // 서드 파티
          const LiveBackgroundWidget(
            palette: Palette(
              colors: [
                Colors.red,
                Colors.green,
              ],
            ),
            velocityX: 1,
            particleMaxSize: 20,
          ),
          // Pull to refresh를 사용하기 위해 RefreshIndicator를 사용한다.
          RefreshIndicator(
            // 반복되는 상수는 하나로 관리한다. 명확하게 알기 어려운 상수를 magic number라고 한다. magic number를 사용하지 않도록 주의한다.
            edgeOffset: TtossAppBar.appBarHeight,
            // onRefresh는 Future<void>를 반환해야 한다.
            onRefresh: () async {
              await sleepAsync(500.ms);
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: TtossAppBar.appBarHeight + 10,
                  bottom: MainScreenState.bottomNavigatorHeight),
              child: Column(
                children: [
                  // rive 애니메이션은 벡터 기반 애니메이션이기 때문에 size를 반드시 지정해 줘야 한다.
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: RiveLikeButton(
                      isLike,
                      onTapLike: (isLike) {
                        setState(() {
                          this.isLike = isLike;
                        });
                      },
                    ),
                  ),
                  BigButton(
                    "토스뱅크",
                    onTap: () {
                      context.showSnackbar("토스뱅크를 눌렀어요.");
                    },
                  ),
                  height10,
                  RoundedContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "자산".text.bold.white.make(),
                      height5,
                      // 스프레드 연산자를 사용하여 해당 리스트를 보여준다.
                      ...bankAccounts.map((e) => BankAccountWidget(e)).toList()
                    ],
                  )),
                ],
              )
                  .pSymmetric(h: 20)
                  .animate()
                  .slideY(duration: 1000.ms)
                  .fadeIn(), // 처음 한 번만 호출된다. fadeIn, delay 등을 조합해 서용할 수 있다.
            ),
          ),
          const TtossAppBar()
        ],
      ),
    );
  }

  void showSnackbar(BuildContext context) {
    context.showSnackbar('snackbar 입니다.',
        extraButton: Tap(
          onTap: () {
            context.showErrorSnackbar('error');
          },
          child: '에러 보여주기 버튼'
              .text
              .white
              .size(13)
              .make()
              .centered()
              .pSymmetric(h: 10, v: 5),
        ));
  }

  Future<void> showConfirmDialog(BuildContext context) async {
    final confirmDialogResult = await ConfirmDialog(
      '오늘 기분이 좋나요?',
      buttonText: "네",
      cancelButtonText: "아니오",
    ).show();
    debugPrint(confirmDialogResult?.isSuccess.toString());

    confirmDialogResult?.runIfSuccess((data) {
      ColorBottomSheet(
        '❤️',
        context: context,
        backgroundColor: Colors.yellow.shade200,
      ).show();
    });

    confirmDialogResult?.runIfFailure((data) {
      ColorBottomSheet(
        '❤️힘내여',
        backgroundColor: Colors.yellow.shade300,
        textColor: Colors.redAccent,
      ).show();
    });
  }

  Future<void> showMessageDialog() async {
    final result = await MessageDialog("안녕하세요").show();
    debugPrint(result.toString());
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
