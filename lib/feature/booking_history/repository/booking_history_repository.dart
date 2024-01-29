import 'package:get/get_connect/http/src/response/response.dart';
import '../../../data/provider/client_api.dart';
import '../../../utils/app_constants.dart';

class BookingHistoryRepo{
  final ApiClient apiClient;
  BookingHistoryRepo({required this.apiClient});

  Future<Response> getBookingList(String requestType,int offset) async {
    return await apiClient.getData("${AppConstants.bookingRequestUrl}?limit=10&offset=$offset&booking_status=$requestType");
  }
}
