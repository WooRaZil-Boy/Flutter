import 'package:fast_app_base/screen/notification/w_notification_item.dart';
import 'package:flutter/material.dart';

import 'd_notification.dart';
import 'notifications_dummy.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Flutter에서 Sliver는 스크롤 가능한 위젯들의 일부로, 스크롤 영역 내에서 동적으로 크기가 변하는 위젯을 구현할 때 사용된다. 
  // Sliver 위젯들은 CustomScrollView 내에서 사용되며, 스크롤되는 콘텐츠를 렌더링하는 데 사용된다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack에서는 가장 위의 widget이 가장 아래에 그려지지만, CustomScrollView에서는 반대이다.
      // 빨간색 색상의 text에 노란색 밑줄이 있다면, theme가 적용되지 않았기 때문이다.
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("알림"),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => NotificationItemWidget(
                notification: notificationDummies[index],
                onTap: () {
                  NotificationDialog([notificationDummies[0], notificationDummies[1]]).show();
                },
              ),
              childCount: notificationDummies.length,
            ),
          )
        ],
      ),
    );
  }
}
