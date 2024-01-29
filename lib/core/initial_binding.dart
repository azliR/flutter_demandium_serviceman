import 'package:demandium_serviceman/feature/conversation/controller/conversation_controller.dart';
import 'package:demandium_serviceman/feature/conversation/repo/conversation_repo.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/feature/booking_history/controller/history_screen_controller.dart';
import 'package:demandium_serviceman/feature/booking_history/repository/booking_history_repository.dart';
import 'package:demandium_serviceman/feature/booking_list/controller/booking_list_controller.dart';
import 'package:demandium_serviceman/feature/booking_list/repository/booking_list_repo.dart';
import 'package:demandium_serviceman/feature/html/controller/webview_controller.dart';
import 'package:demandium_serviceman/feature/html/repository/html_repo.dart';
import 'package:demandium_serviceman/feature/notifications/controller/notification_controller.dart';
import 'package:demandium_serviceman/feature/notifications/repository/notification_repo.dart';
import 'package:demandium_serviceman/feature/profile/controller/profile_controller.dart';
import 'package:demandium_serviceman/feature/profile/repository/user_repo.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(()=>NotificationController(notificationRepo: NotificationRepo(apiClient:  Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => BookingHistoryController(bookingHistoryRepo: BookingHistoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => BookingListController(bookingListRepo: BookingListRepo(apiClient: Get.find())));
    Get.lazyPut(() => ProfileController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
  }
}