import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var imageIndexChannel: FlutterMethodChannel? = nil //TODO: 이렇게 말고 DI 하는 방법 없나?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let factory = FlutterViewFactory()
    
    registrar(forPlugin: "test") //FlutterPlugin 컨텍스트에 액세스하고 이벤트를 콜백하는 클래스
        .register(factory, withId: "FlutterView") //Flutter에서 사용한 UiKitView의 viewType과 일치해야 한다.
    //info.plist 에서
    //<key>io.flutter.embedded_views_preview</key>
    //<string>YES</string>
    //추가해 줘야 한다.
    
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    imageIndexChannel = FlutterMethodChannel(name: "flutter/image", binaryMessenger: controller)

    if let imageIndexChannel = imageIndexChannel {
        imageIndexChannel.setMethodCallHandler { call, result in
            //Flutter에서 메서드를 호출했을 때, Swift에서 Flutter로 보낸다.
            guard call.method == "getImageIndex" else {
                return
            }
            
            result(100)
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    //여기서 UIKitView로 접근할 수 있는 방법이 있어야 할듯
    //Channel DI 하는 방법이랑.
}
