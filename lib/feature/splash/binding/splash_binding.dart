import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }
}