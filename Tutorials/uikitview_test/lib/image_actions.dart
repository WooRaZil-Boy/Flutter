import "dart:async";
import "package:flutter/services.dart";
import "package:flutter/material.dart";
import "main.dart";


typedef void ImageActionHandler(int index);

class ImageActions { //생성자
  MethodChannel _imageChannel;

  ImageActions() {
    this._imageChannel = MethodChannel("flutter/image");
  }

  void init(MyHomePageState state) {
    _imageChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "receiveIndex") {
        state.setState(() {
          state.imageIndex = call.arguments;
        });
      }
    });
  }

  Future<int> getImageIndex() async {
    int imageIndex;

    try {
      final int result = await _imageChannel.invokeMethod("getImageIndex");
      imageIndex = result;
    } on PlatformException catch (e) {
      imageIndex = 0;
    }

    return imageIndex;
  }

  Future<int> receiveIndex() async {
    int imageIndex = 0;

    _imageChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "receiveIndex") {
        imageIndex = call.arguments;
      } 
    });

    return imageIndex;
  }
}