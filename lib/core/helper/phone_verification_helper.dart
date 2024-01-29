import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class VerifyPhoneHelper {

  static Future<String> getCountryCode(String numberWithCountryCode) async {
    String countryCode = '';

    PhoneNumber phoneNumber = await PhoneNumberUtil().parse(numberWithCountryCode);
    countryCode =phoneNumber.countryCode;
    return countryCode;
  }

  static Future<bool> phoneVerify(String numberWithCountryCode) async {
    bool isValid = (!GetPlatform.isWeb && GetPlatform.isAndroid) ? false : true;

    if(!GetPlatform.isWeb && GetPlatform.isAndroid) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(numberWithCountryCode);
        numberWithCountryCode = '+${phoneNumber.countryCode}${phoneNumber.nationalNumber}';
        isValid = true;
      } catch (e) {
        if (kDebugMode) {
          print("");
        }
      }
    }

    return isValid;
  }

}