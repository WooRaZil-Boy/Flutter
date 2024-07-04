import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';
// 파일이 생성되기 전에 파일을 import 하는 것이 이상하게 보일 수 있지만
// 생성기 스크립트가 어떤 파일을 생성할지 모르면 실패합니다.
part 'recipe_service.chopper.dart';

const String apiKey = '186f49da8995bf8f6822b358f3cd7e2f';
const String apiId = '0a718960';
const String apiUrl = 'https://api.edamam.com';

// @ChopperApi()는 초퍼 생성기에 part 파일을 빌드하도록 지시합니다.
// 이렇게 생성된 파일의 이름은 이 파일과 동일하지만 .chopper가 추가됩니다.
// 이 경우 recipe_service.chopper.dart가 됩니다. 이러한 파일에는 상용구 코드가 포함됩니다.
@ChopperApi()
// 메서드 시그니처만 정의하면 되기 때문에 RecipeService는 abstract 클래스입니다.
abstract class RecipeService extends ChopperService {
  // @Get은 제너레이터에 이 요청이 search이라는 이름의 path를 가진 GET 요청임을 알려주는 어노테이션입니다.
  @Get(path: 'search')
  // APIRecipeQuery를 사용하여 Response의 Future를 반환하는 함수를 정의합니다.
  // 추상 Result에는 값 또는 오류가 포함됩니다.
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      // Chopper @Query 어노테이션을 사용하여 query 문자열과 from, to 정수를 전달을 받습니다.
      // 이 메서드에는 본문이 없습니다. 제너레이터 스크립트가 모든 매개변수와 함께 이 함수의 본문을 생성합니다.
      @Query('q') String query, @Query('from') int from, @Query('to') int to
  );

  static RecipeService create() {
    // ChopperClient 인스턴스를 생성합니다.
    final client = ChopperClient(
      // apiUrl 상수를 사용하여 기본 URL을 전달합니다.
      baseUrl: apiUrl,
      // 두 개의 인터셉터를 전달합니다.
      // _addQuery()는 쿼리에 키와 ID를 추가합니다.
      // HttpLoggingInterceptor는 Chopper의 일부이며 모든 호출을 기록합니다.
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      // converter를 ModelConverter의 인스턴스로 설정합니다.
      converter: ModelConverter(),
      // 내장된 JsonConverter를 사용하여 오류를 디코딩합니다.
      errorConverter: const JsonConverter(),
      // 생성기 스크립트를 실행할 때 생성되는 서비스를 정의합니다.
      services: [
        _$RecipeService()
      ],
    );
    // 생성된 서비스의 인스턴스를 반환합니다.
    return _$RecipeService(client);
  }
}

// 이 메서드의 장점은 한 번 연결하면 모든 호출이 이 메서드를 사용한다는 것입니다.
// 지금은 호출이 하나만 있지만 더 추가하면 해당 키가 자동으로 포함됩니다.
// 그리고 모든 호출에 새 매개 변수를 추가하려면 이 메서드만드변경하면 됩니다.
Request _addQuery(Request req) {
  // 기존 Request 매개변수의 키-값 쌍을 포함하는 Map을 생성합니다.
  final params = Map<String, dynamic>.from(req.parameters);
  // 맵에 app_id 및 app_key 매개변수를 추가합니다.
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  // 맵에 포함된 파라미터가 포함된 Request의 새 복사본을 반환합니다.
  return req.copyWith(parameters: params);
}