import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class HtmlRepository{
  final ApiClient apiClient;
  HtmlRepository({required this.apiClient});

  Future<Response> getPagesContent() async {
    return await apiClient.getData(AppConstants.pages);
  }

}
