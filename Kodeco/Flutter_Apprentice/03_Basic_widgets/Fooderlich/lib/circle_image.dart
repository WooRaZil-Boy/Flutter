import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.imageProvider,
    this.imageRadius = 20
  });

  final double imageRadius;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    // CircleAvatar는 머티리얼 라이브러리에서 제공하는 위젯입니다. 반경이 imageRadius인 흰색 원으로 정의됩니다.
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      // 바깥쪽 원 안에는 사용자의 프로필 이미지가 포함된 더 작은 원인 또 다른 CircleAvatar가 있습니다.
      // 안쪽 원을 더 작게 만들면 흰색 테두리 효과를 얻을 수 있습니다.
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
