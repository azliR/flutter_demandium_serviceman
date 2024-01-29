import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class NotificationRepo {
final ApiClient apiClient;
final SharedPreferences sharedPreferences;
NotificationRepo({required this.sharedPreferences, required this.apiClient});

Future<Response> getNotification(int offset) async {
  return await apiClient.getData(
      '${AppConstants.notificationUrl}?limit=30&offset=$offset');
}

Future <int?> getNotificationCount() async {
  return sharedPreferences.getInt(AppConstants.notificationCount);
}
void setNotificationCount(int count){
  sharedPreferences.setInt(AppConstants.notificationCount, count);
}
}

