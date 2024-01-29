import 'package:demandium_serviceman/core/core_export.dart';
import 'package:demandium_serviceman/feature/auth/widgets/custom_text_field.dart';
import 'package:get/get.dart';


class NewPassScreen extends StatefulWidget {
  final String identity;
  final String identityType;
  final String otp;
  const NewPassScreen({super.key, required this.identity,required this.otp, required this.identityType});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  String _identity='';

  @override
  void initState() {
    super.initState();
    _identity = widget.identity;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: "change_password".tr),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

            CustomTextField(
              title: 'New_Password'.tr,
              hintText: "********",
              controller: _newPasswordController,
              focusNode: _newPasswordFocus,
              nextFocus: _confirmPasswordFocus,
              inputType: TextInputType.visiblePassword,
              isPassword: true,
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault),

            CustomTextField(
              title: "Confirm_New_Password".tr,
              hintText: "********",
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocus,
              inputAction: TextInputAction.done,
              inputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            GetBuilder<AuthController>(builder: (controller){
              return controller.isLoading!?
              Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor),)

              :CustomButton(
                fontSize: Dimensions.fontSizeDefault,
                btnTxt: "change_password".tr,
                onPressed: ()=> _resetPassword(
                    _identity,widget.otp,_newPasswordController.text.trim(),_confirmPasswordController.text.trim()
                ),
              );
            })
          ]),
        ),
      ),
    );
  }
  void _resetPassword(String identity,String otp,String password,String conPassword){
    String password0 = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    if (password0.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (password0.length < 8) {
      showCustomSnackBar('password_should_be'.tr);
    }else if(confirmPassword.isEmpty){
      showCustomSnackBar("enter_confirm_password".tr);
    }else if(password0 != confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    }else {
      Get.find<AuthController>().resetPassword(identity,widget.identityType,otp,password,conPassword);
    }
  }
}
