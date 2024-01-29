import 'package:get/get.dart';
import '../controller/history_screen_controller.dart';
import '../repository/booking_history_repository.dart';

class BookingHistoryBinding extends Bindings {  @override
void dependencies() {
  Get.lazyPut(() => BookingHistoryController(bookingHistoryRepo: BookingHistoryRepo(apiClient: Get.find())));
}
}
