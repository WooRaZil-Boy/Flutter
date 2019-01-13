package com.example.batterylevel

import android.os.Bundle
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() { //onCreate 함수는 해당 Activity의 진입점이다.
  private val CHANNEL = "samples.flutter.io/battery" //Flutter 클라이언트에서 사용한 것과 동일한 채널이름을 사용해야 한다.

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      //onCreate() 메서드에서 MethodChannel을 생성하고 setMethodCallHandler를 호출한다.
      //이후 실제 Kotlin 코드로 해당 로직(여기서는 battery level 확인)을 구현하면 된다.
      if (call.method == "getBatteryLevel") { //Flutter에서 호출한 메서드 이름
        var batteryLevel = getBatteryLevel()

        if (batteryLevel != -1) {
          result.success(batteryLevel) //Flutter로 결과를 보낸다.
        } else {
          result.error("UNAVAILABLE", "Battery level not available.", null) //Flutter로 오류를 보낸다.
        }
      } else {
        result.notImplemented()
      }
    }
  }

  private fun getBatteryLevel() : Int { //Kotlin 코드로 해당 로직을 작성한다.
    val batteryLevel: Int

    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    } else {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    }

    return batteryLevel
  }
}

