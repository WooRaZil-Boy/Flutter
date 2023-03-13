import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../screens/screens.dart';

// AppRouter는 탐색 코드를 한 곳에 보관하는 GoRouter의 래퍼입니다.
class AppRouter {
  AppRouter(
    this.appStateManager,
    this.profileManager,
    this.groceryManager,
  );

  // GoRouter가 앱 상태 변경을 수신하여 오류나 리디렉션을 처리합니다.
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  // GoRouter 인스턴스를 보유하는 변수를 생성합니다.
  late final router = GoRouter(
    // 디버깅을 활성화합니다. 사용자가 어떤 경로로 이동하는지 확인하고 경로에 문제가 있는지 감지하는 데 특히 유용합니다.
    // 앱을 출시하기 전에 debugLogDiagnostics 플래그를 제거해야 합니다.
    debugLogDiagnostics: true,
    // 라우터가 앱 상태 변경을 수신하도록 설정합니다. 상태가 변경되면 라우터가 경로를 다시 빌드하도록 트리거합니다.
    refreshListenable: appStateManager,
    // 라우팅의 초기 위치를 설정합니다.
    initialLocation: '/login',
    // 사용하는 모든 경로를 정의합니다. 나중에 추가할 수 있습니다.
    routes: [
      GoRoute(
        // name은 경로의 이름을 지정합니다. 설정된 경우 고유한 문자열 이름을 제공해야 하며 비워 둘 수 없습니다.
        name: 'login',
        // path는 해당 경로입니다.
        path: '/login',
        // builder는 이 경로의 페이지 빌더입니다. 화면 위젯을 빌드하는 역할을 합니다.
        builder: (context, state) => const LoginScreen()
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // home이라는 새 경로를 정의합니다. 이 경로는 매개변수를 사용하기 때문에 특별합니다.
      // home 경로는 Explore, Recipes 또는 To Buy 탭으로 이동하는 tab 매개변수로 구성됩니다.
      GoRoute(
        name: 'home',
        // tab 매개변수를 사용하여 경로를 정의합니다. 콜론 뒤에 매개변수 이름이 옵니다.
        path: '/:tab',
        builder: (context, state) {
          // GoRouterState 매개변수에서 탭의 값을 가져와 정수로 변환합니다.
          final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
          // 탭을 Home 위젯으로 전달합니다.
          return Home(
            key: state.pageKey,
            currentTab: tab
          );
        },
        // GoRoute 내에 하위 경로를 가질 수 있습니다.
        routes: [
          GoRoute(
            name: 'item',
            // id를 매개변수로 사용하여 하위 경로 item을 정의합니다.
            path: 'item/:id',
            builder: (context, state) {
              // 빌더 내에서 itemId를 추출합니다.
              final itemId = state.params['id'] ?? '';
              // itemId에 대한 GroceryItem 객체를 가져옵니다.
              final item = groceryManager.getGroceryItem(itemId);
              // GroceryItemScreen을 반환하고 항목을 전달합니다. 항목이 null이면 사용자가 새 항목을 생성합니다.
              return GroceryItemScreen(
                originalItem: item,
                onCreate: (item) {
                  // 사용자가 새 항목을 생성하면 새 항목이 장보기 목록에 추가됩니다.
                  groceryManager.addItem(item);
                },
                onUpdate: (item) {
                  // 사용자가 품목을 업데이트하면 장보기 목록에 있는 품목이 업데이트됩니다.
                  groceryManager.updateItem(item);
                },
              );
            }
          ),
          GoRoute(
            name: 'profile',
            path: 'profile',
            builder: (context, state) {
              // 사용자가 현재 있는 탭을 가져옵니다.
              final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
              // 사용자 프로필과 사용자가 마지막으로 있었던 탭을 전달하여 ProfileScreen을 반환합니다.
              return ProfileScreen(
                user: profileManager.getUser,
                currentTab: tab,
              );
            },
            // 더 많은 하위 경로를 설정할 수 있습니다.
            routes: [
              GoRoute(
                name: 'rw',
                path: 'rw',
                builder: (context, state) => const WebViewScreen(),
              ),
            ],
          )
        ]
      ),
    ],
    // GoRouter를 사용자 지정하여 고유한 오류 페이지를 표시할 수 있습니다.
    // 특히 웹 앱의 경우 사용자가 잘못된 URL 경로를 입력하는 경우가 흔합니다.
    // 웹 앱은 일반적으로 404 오류 화면을 표시합니다.
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString()
            )
          ),
        )
      );
    },
    // 단순히 경로를 정의한다고 해서 GoRouter가 온보딩 화면으로 이동하는 것은 아닙니다.
    // GoRouter로 리디렉션을 구현할 수 있습니다. GoRouter는 redirect 핸들러를 사용하여 이를 수행합니다.
    // 대부분의 앱에는 일종의 로그인 인증 흐름이 필요하며 리디렉션은 이러한 상황에 적합합니다.
    // 예를 들어 다음과 같은 시나리오가 앱에서 발생할 수 있습니다:
    //
    // - 사용자가 앱에서 로그아웃합니다.
    // - 사용자가 로그인이 필요한 제한된 페이지로 이동하려고 합니다.
    // - 사용자의 세션 토큰이 만료됩니다. 이 경우 사용자는 자동으로 로그아웃됩니다.
    //
    // 이 모든 경우에 사용자를 로그인 화면으로 다시 리디렉션하면 좋을 것입니다.
    redirect: (state) {
      // 사용자가 로그인했는지 확인합니다.
      final loggedIn = appStateManager.isLoggedIn;
      // 사용자가 로그인 위치에 있는지 확인합니다.
      final loggingIn = state.subloc == '/login';
      // 아직 로그인하지 않은 경우 사용자가 로그인하도록 리디렉션합니다.
      if (!loggedIn) return loggingIn ? null : '/login';

      // 사용자가 이미 로그인했으므로 이제 온보딩 가이드를 완료했는지 확인합니다.
      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      // 사용자가 온보딩 위치에 있는지 확인합니다.
      final onboarding = state.subloc == '/onboarding';
      // 사용자가 아직 온보딩을 완료하지 않은 경우 온보딩으로 리디렉션합니다.
      if (!isOnboardingComplete) {
        return onboarding ? null : '/onboarding';
      }
      // 사용자가 로그인하여 온보딩을 완료했습니다. 사용자를 홈으로 리디렉션합니다.
      if (loggingIn || onboarding) return '/${FooderlichTab.explore}';
      // 리디렉션을 중지하려면 null을 반환합니다.
      return null;
    }
  );
}