import 'package:get/get.dart';
import 'package:demandium_serviceman/feature/booking_list/controller/booking_list_controller.dart';
import 'package:demandium_serviceman/feature/booking_list/repository/booking_list_repo.dart';


class BookingListBinding extends Bindings {@override
  void dependencies(){
    Get.lazyPut(() => BookingListController(bookingListRepo: BookingListRepo(apiClient: Get.find())));
  }
}
