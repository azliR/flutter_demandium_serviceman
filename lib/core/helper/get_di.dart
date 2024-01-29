import 'dart:convert';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';


Future<Map<String, Map<String, String>>> init() async{
  //core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  //Repository
  Get.lazyPut(() => LanguageRepo());

  //Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  //Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => BookingListController(bookingListRepo: BookingListRepo(apiClient: Get.find())));
  Get.lazyPut(() => DashboardController(dashboardRepository: DashboardRepository(apiClient: Get.find())));

  //Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsonValue = {};
    mappedJson.forEach((key, value) {
      jsonValue[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = jsonValue;
  }
  return languages;
}
