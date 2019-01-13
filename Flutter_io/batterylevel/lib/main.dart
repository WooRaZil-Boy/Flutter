import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  //MethodChannel로 배터리 레벨을 반환하는 단일 플랫폼 메서드를 구성한다.
  //채널의 클라이언트와 호스트는 채널 생성자에서 전달된 채널 이름으로 연결된다. 단일 앱에서 사용되는 모든 채널 이름은 고유해야 한다.

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    
    try { //시뮬레이터에서 실행하거나, 지원하지 않는 API의 경우 오류가 날 수 있으므로 try-catch로 감싼다.
      final int result = await platform.invokeMethod("getBatteryLevel"); //각 플랫폼에 호출할 구체적인 메서드를 지정한다.
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text("Get Battery Level"),
              onPressed: _getBatteryLevel,
            ),
            Text(
              _batteryLevel
            )
          ],
        ),
      ),
    );
  }
}

//Flutter는 Android의 Java, Kotlin 과 iOS의 Objective-C, Swift 코드를 사용해 플랫폼 별 API를 호출할 수 있다.
//Flutter의 플랫폼 별 API 지원은 코드 생성이 아닌 flexible message 를 전달에 의존한다.
// • Flutter 앱은 platform channel을 사용해 Android와 iOS에 메시지를 보낸다.
// • 플랫폼 채널에서 메시지를 수신 한 후, 네이티브 프로그래밍 언어를 사용해 플랫폼 별 API를 호출하고 response를 Flutter로 전달한다.




//Architectural overview: platform channels
//https://flutter.io/docs/development/platform-integration/platform-channels#architectural-overview-platform-channels
//메시지의 전송과 응답은 비동기적으로 구현된다. 클라이언트(Flutter)에서는 MethodChannel를 사용해, 메시지를 보낸다.
//플랫폼에서는 MethodChannel(Android)와 FlutterMethodChannel(iOS)로 호출을 수신하고 결과를 반환한다.
//MethodChannel은 비동기 메서드 호출을 사용해, 플랫폼 플러그인과 통신하는 채널이다.
//이를 클래스를 사용하면, boilerplate가 거의 없는 플랫폼 플러그인을 작성할 수 있다.
//이와 반대로 역방향으로도 가능하다.

//Platform channel data types support and codecs
//The standard platform channel은 표준 메시지 코덱을 사용한다. 메시지에 대한 값의 serialization와 deserialization는 자동으로 수행된다.
//각 플랫폼 별 자료형 타입은 다음과 같다.

//Dart	          Android	            iOS
//null	          null	              nil (NSNull when nested)
//bool	          java.lang.Boolean	  NSNumber numberWithBool:
//int	            java.lang.Integer	  NSNumber numberWithInt:
//int(32비트 이상)	  java.lang.Long	    NSNumber numberWithLong:
//double	        java.lang.Double	  NSNumber numberWithDouble:
//String	        java.lang.String	  NSString
//Uint8List	      byte[]	            FlutterStandardTypedData typedDataWithBytes:
//Int32List	      int[]	              FlutterStandardTypedData typedDataWithInt32:
//Int64List	      long[]	            FlutterStandardTypedData typedDataWithInt64:
//Float64List	    double[]	          FlutterStandardTypedData typedDataWithFloat64:
//List	          java.util.ArrayList	NSArray
//Map	            java.util.HashMap	  NSDictionary




//Example: Calling platform-specific iOS and Android code using platform channels
//이 예제는 플랫폼 별로 API를 호출하여 현재 배터리를 확인하고 표시한다.
//BatteryManager(Android)와 device.batteryLevel(iOS) API를 사용한다.

//Step 1: Create a new app project
//터미널에서 flutter create batterylevel 를 입력한다.
//기본 언어는 Java / Objective-C 이다. Kotlin과 Swift를 사용한다면, -i, -a 플래그를 추가해 줘야 한다.
// flutter create -i swift -a kotlin batterylevel

//Step 3b: Add an Android platform-specific implementation using Kotlin
//Android Studio에서 Kotlin의 MainActivity를 편집하면 된다.

//Step 4b: Add an iOS platform-specific implementation using Swift
//Xcode에서 ios의 xcworkspace를 편집하면 된다(AppDelegate).




//Custom channels and codecs
//MethodChannel 외에도 BasicMessageChannel, BinaryCodec, StringCodec, JSONMessageCodec 등의 클래스를 사용하거나 사용자 지정 코덱을 만들 수 있다.