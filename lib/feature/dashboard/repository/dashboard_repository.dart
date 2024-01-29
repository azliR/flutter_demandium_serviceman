import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class DashboardRepository{
    final ApiClient apiClient;
  DashboardRepository({required this.apiClient});

    Future<Response> getDashboardData() async {
      return await apiClient.getData("${AppConstants.dashboardUrl}?sections=top_cards,recent_bookings");
    }

  Future<Response> getMonthlyChartData(String year,String month) async {
    return await apiClient.getData("${AppConstants.dashboardUrl}?sections=booking_stats&stats_type=full_month&year=$year&month=$month");
  }

    Future<Response> getYearlyChartData(String year) async {
      return await apiClient.getData("${AppConstants.dashboardUrl}?sections=booking_stats&stats_type=full_year&year=$year");
  }

}
