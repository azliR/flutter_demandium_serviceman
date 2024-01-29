// ignore_for_file: deprecated_member_use

import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import '../widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  const SignInScreen({super.key, required this.exitFromApp});

  @override
  SignInScreenState createState() => SignInScreenState();
}


class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  String _countryDialCode='+880';
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState(){
    super.initState();
    if(Get.find<SplashController>().configModel.content != null){

      if(Get.find<AuthController>().getUserCountryCode()!=''){
        _countryDialCode = Get.find<AuthController>().getUserCountryCode();
      }else{
        _countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>()
            .configModel.content!.countryCode!).dialCode!;}
      }
    _phoneController.text =  Get.find<AuthController>().getUserNumber()
        .replaceFirst( Get.find<AuthController>().getUserCountryCode(), '');

    _passwordController.text = Get.find<AuthController>().getUserPassword();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr, style: const TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        }else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Center(
              child: GetBuilder<SplashController>(builder: (splashController) {
                  return GetBuilder<AuthController>(builder: (authController) {
                    return Column(children: [
                      Image.asset(Get.isDarkMode?Images.demandiumDarkLogo:Images.demandiumLogo,width: Dimensions.authLogo,),
                      const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      CustomTextField(
                        hintText: 'phone_hint'.tr,
                        controller: _phoneController,
                        focusNode: _phoneFocus,
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.phone,
                        countryDialCode: _countryDialCode,
                        onCountryChanged: (CountryCode countryCode) => _countryDialCode = countryCode.dialCode!,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      CustomTextField(
                        title: 'password'.tr,
                        hintText: 'enter_your_password'.tr,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        inputAction: TextInputAction.done,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ListTile(
                              onTap: () => authController.toggleRememberMe(),
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 20.0,
                                    child: Checkbox(
                                      activeColor: Theme.of(context).primaryColor,
                                      value: authController.isActiveRememberMe,
                                      onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  Text(
                                    'remember_me'.tr,
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                  ),
                                ],
                              ),
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              horizontalTitleGap: 0,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(minimumSize: const Size(1, 40),backgroundColor: Theme.of(context).colorScheme.background),
                            onPressed: () => Get.to(const ForgetPassScreen()),
                            child: Text('forgot_password?'.tr, style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),)
                            ),
                          ),
                      ]),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      !authController.isLoading! ? CustomButton(
                        btnTxt: 'sign_in'.tr,
                        onPressed: authController.acceptTerms! ? () => _login(authController, _countryDialCode) : null,
                      ) : const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                    ]);
                  });
                }
              ),
            ),
          ),
        )),
      ),
    );
  }


  void _login(AuthController authController, String countryDialCode) async {
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String numberWithCountryCode = countryDialCode+phone;

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

    if (phone.isEmpty) {
      showCustomSnackBar('phone_hint'.tr);
    }else if (!isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }else if (password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (password.length < 8) {
      showCustomSnackBar('password_should_be'.tr);
    }else {
      authController.login(numberWithCountryCode, countryDialCode, phone, password).then((status) async {
      });
    }
  }
}
