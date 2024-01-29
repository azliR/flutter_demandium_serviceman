import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool? _isLoading = false;
  bool? _notification = true;
  bool? _acceptTerms = true;

  bool? get isLoading => _isLoading;
  bool? get notification => _notification;
  bool? get acceptTerms => _acceptTerms;


  Future<void> login(String phoneWithCountryCode,String countryCode,String phoneWithoutCountryCode, String password) async {
    _isLoading = true;

    update();
    Response? response = await authRepo.login(phone: phoneWithCountryCode, password: password);
    if (response!.statusCode == 200 && response.body['response_code']=="auth_login_200") {
      if (isActiveRememberMe) {
        authRepo.saveUserNumberAndPassword(phoneWithCountryCode, password,countryCode);
      } else {
        authRepo.clearUserNumberAndPassword();
      }
        authRepo.saveUserToken(response.body['content']['token']);
       Get.find<ProfileController>().getUserInfo().then((value) async {
         if(value.isSuccess!){
           await authRepo.updateToken();
         }
       });
       Get.find<SplashController>().updateLanguage(true);
       showCustomSnackBar('successfully_logged_in'.tr, isError: false);
       Get.offNamed(RouteHelper.getInitialRoute());

    } else {
      _isLoading = false;
      showCustomSnackBar(response.body['message'].toString().capitalizeFirst??response.statusText);
    }
    _isLoading = false;
    update();
  }


  Future<ResponseModel> sendOtpForForgetPassword(String identity, String identityType) async {
    _isLoading = true;
    update();
    Response response = await authRepo.sendOtpForForgetPassword(identity,identityType);

    if (response.statusCode == 200 && response.body["response_code"]=="default_200") {
      _isLoading = false;
      update();
      return ResponseModel(true, "");
    } else {
      _isLoading = false;
      update();
      return ResponseModel(false, response.body["message"] ?? response.statusText);
    }
  }


  Future<ResponseModel> verifyOtpForForgetPasswordScreen(String identity, String identityType, String otp) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyOtpForForgetPassword(identity, identityType, otp);

    if (response.statusCode==200 &&  response.body['response_code'] == 'default_200') {
      _isLoading = false;
      update();
      return ResponseModel(true, "successfully_verified");
    }else{
      _isLoading = false;
      update();
      return ResponseModel(false, response.body["message"] ?? response.statusText);
    }

  }



  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<ResponseModel> verifyToken(String email) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.verifyToken(email, _verificationCode);
    ResponseModel responseModel;
    if (response!.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> resetPassword(String identity,String identityType, String otp, String password, String confirmPassword) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(identity,identityType, otp, password, confirmPassword);

    if (response!.statusCode == 200 && response.body['response_code']=="default_password_reset_200") {
      Get.offNamed(RouteHelper.signIn);
      showCustomSnackBar('password_changed_successfully'.tr,isError: false);
    } else {
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }



  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }


  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms!;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password, String countryCode) {
    authRepo.saveUserNumberAndPassword(number, password, countryCode);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool? setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

}