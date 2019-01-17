import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
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
    
    
    
    

    
    
    
    
    
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
