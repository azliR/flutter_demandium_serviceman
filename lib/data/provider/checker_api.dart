import 'package:demandium_serviceman/core/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/components/custom_snackbar.dart';
import 'package:demandium_serviceman/feature/auth/controller/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      if(Get.currentRoute!=RouteHelper.getSignInRoute('splash')){
        Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
      }
    }if(response.statusCode == 500){
      showCustomSnackBar(response.statusText);
    }else {
      showCustomSnackBar(response.statusText);
    }
  }
}