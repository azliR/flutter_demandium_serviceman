import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class BookingListRepo{
  final ApiClient apiClient;
  BookingListRepo({required this.apiClient});

  Future<Response> getBookingList(String requestType, int offset) async {
    return await apiClient.getData("${AppConstants.bookingRequestUrl}?limit=7&offset=$offset&booking_status=$requestType");
  }
}
