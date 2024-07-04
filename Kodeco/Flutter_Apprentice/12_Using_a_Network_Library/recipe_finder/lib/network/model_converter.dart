import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'model_response.dart';
import 'recipe_model.dart';

// ModelConverter를 사용하여 Chopper Converter 추상 클래스를 구현합니다.
class ModelConverter implements Converter {
  // Request을 받아 새 Request을 반환하는 convertRequest()를 재정의합니다.
  @override
  Request convertRequest(Request request) {
    // jsonHeaders를 사용하여 요청 유형이 application/json임을 나타내는 헤더를 요청에 추가합니다.
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false
    );

    // 서버 API에서 요구하는 대로 encodeJson()을 호출하여 요청을 JSON으로 인코딩된 요청으로 변환합니다.
    return encodeJson(req);
  }

  // 향후 앱을 쉽게 확장할 수 있도록 인코딩과 디코딩을 분리합니다.

  // Request 인스턴스를 가져와 서버로 전송할 준비가 된 인코딩된 사본을 반환합니다.
  Request encodeJson(Request request) {
    // request 헤더에서 콘텐츠 유형을 추출합니다.
    final contentType = request.headers[contentTypeKey];
    // ontentType이 application/json 유형인지 확인합니다.
    if (contentType != null && contentType.contains(jsonHeaders)) {
      // JSON으로 인코딩된 본문으로 요청의 복사본을 만듭니다.
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;

    // JSON을 다루고 있는지 확인하고 response을 body이라는 문자열로 디코딩합니다.
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }

    try {
      // JSON 디코딩을 사용하여 해당 문자열을 맵 표현으로 변환합니다.
      final mapData = json.decode(body);
      // 오류가 발생하면 서버는 status라는 필드를 반환합니다.
      // 여기서 맵에 해당 필드가 포함되어 있는지 확인합니다. 그렇다면 Error 인스턴스를 포함하는 응답을 반환합니다.
      if (mapData['status'] != null) {
        return response.copyWith<BodyType>(
          body: Error(Exception(mapData['status'])) as BodyType
        );
      }
      // APIRecipeQuery.fromJson()을 사용하여 맵을 모델 클래스로 변환합니다.
      final recipeQuery = APIRecipeQuery.fromJson(mapData);

      // recipeQuery를 래핑하는 성공적인 응답을 반환합니다.
      return response.copyWith<BodyType>(
        body: Success(recipeQuery) as BodyType
      );
    } catch (e) {
      // 다른 종류의 오류가 발생하면 일반 Error 인스턴스로 응답을 래핑하세요.
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(
        body: Error(e as Exception) as BodyType
      );
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}