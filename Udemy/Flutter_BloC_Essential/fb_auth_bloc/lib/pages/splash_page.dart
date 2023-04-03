import 'package:fb_auth_bloc/blocs/auth/auth_bloc.dart';
import 'package:fb_auth_bloc/pages/home_page.dart';
import 'package:fb_auth_bloc/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 앱의 진입 페이지로 auth가 완료 되었으면 HomePage로, 완료되지 않았다면 SigninPage로 이동한다.
class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Auth state를 listen 해서 HomePage / SigninPage 이동을 분기하고,
    // 앱을 시작할 때나 리부팅할 때등 상태가 unknown 일때 CircularProgressIndicator를 표시한다.
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          // state가 동시에 여러 번 바뀌게 되면 dialog가 여러 번 호출되는 경우도 있다. 이를 해결하기 위해 pushNamedAndRemoveUntil를 사용하고, route의 name을 확인한다.
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninPage.routeName,
            (route) {
              print('route.settings.name: ${route.settings.name}');
              print('ModalRoute: ${ModalRoute.of(context)!.settings.name}');

              return route.settings.name ==
                      ModalRoute.of(context)!.settings.name
                  ? true
                  : false;
            },
          );
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
