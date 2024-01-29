
import 'package:country_code_picker/country_code_picker.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:demandium_serviceman/feature/auth/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}



class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _identityController = TextEditingController();

  String identityType ="";
  final ConfigModel _configModel = Get.find<SplashController>().configModel;

  @override
  void initState() {
    super.initState();
    identityType = _configModel.content?.forgetPasswordVerificationMethod??"";
  }

  @override
  Widget build(BuildContext context) {
    String countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: "forgot_password".tr),

      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Column(children: [

            Image.asset(Images.forgetPassword,height: 100,width: 100,),

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge*1.5),
              child: Center(child: Text('${"please_enter_your".tr} ${identityType=="email"?"email_address".tr.toLowerCase():"phone_number".tr.toLowerCase()} ${"to_receive_a_verification_code".tr}',
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7)),textAlign: TextAlign.center,
              )),
            ),

            (identityType=="email")?
            CustomTextField(
              hintText: "enter_email_address".tr,
              controller: _identityController,
              inputType: TextInputType.emailAddress,
              title: "email".tr,
            ): CustomTextField(
              hintText: 'phone_humber_hint'.tr,
              controller: _identityController,
              inputType: TextInputType.phone,
              countryDialCode: countryDialCode,
              onCountryChanged: (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
            ),

            const SizedBox(height: Dimensions.paddingSizeLarge),

            GetBuilder<AuthController>(builder: (authController) {
              return !authController.isLoading! ?
              CustomButton(btnTxt: "send_otp".tr,
                onPressed: (){
                      _forgetPass(countryDialCode,authController);
              },) : Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor));
            }),
            const SizedBox(height: 150),

          ]),
        )),
      )))),
    );
  }

  void _forgetPass(String countryDialCode,AuthController authController) async {
    String phone = countryDialCode + _identityController.text.trim();
    String email = _identityController.text.trim();
    String identity = identityType=="phone"?phone:email;

    if (_identityController.text.isEmpty) {
      if(identityType=="phone"){
        showCustomSnackBar('phone_humber_hint'.tr);
      }else{
        showCustomSnackBar('enter_email_address'.tr);
      }
    }
    else {
      authController.sendOtpForForgetPassword(identity,identityType).then((status){
        if(status.isSuccess!){
          Get.toNamed(RouteHelper.getVerificationRoute(identity,identityType));
        }else{
          showCustomSnackBar(status.message.toString().capitalizeFirst);
        }
      });
      }
    }
}


