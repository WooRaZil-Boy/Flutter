import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.io/battery", binaryMessenger: controller)
    //Flutter 클라이언트에서 사용한 것과 동일한 채널이름을 사용해야 한다.
    //MethodChannel을 생성하고 setMethodCallHandler를 호출한다.
    //이후 실제 Swift 코드로 해당 로직(여기서는 battery level 확인)을 구현하면 된다.)
    
    batteryChannel.setMethodCallHandler { [weak self] call, result in
        guard call.method == "getBatteryLevel" else { //Flutter에서 호출한 메서드 이름
            return
        }
        
        self?.receiveBatteryLevel(result: result) //Flutter로 결과를 보낸다.
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        if device.batteryState == UIDeviceBatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil)) //오류 있는 경우
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}
