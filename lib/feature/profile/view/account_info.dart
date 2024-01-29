import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<ProfileController>(
          builder: (controller){
            return Form(
              key: controller.passUpdateKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customRichText("phone_number".tr,context),
                  NonEditableTextField(text: controller.userInfo.phone??"",),

                  customRichText("new_password".tr,context),
                  CustomTextFormField(
                    isShowSuffixIcon: true,
                    isPassword: true,
                    controller: controller.passController,
                    hintText: "enter_new_password".tr,
                    isShowBorder: true,
                  ),

                  customRichText("Confirm_New_Password".tr,context),
                  CustomTextFormField(
                    isShowSuffixIcon: true,
                    isPassword: true,
                    controller: controller.confirmPassController,
                    hintText: "enter_confirm_password".tr,
                    isShowBorder: true,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),

                  controller.isLoading ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       CircularProgressIndicator(color: Theme.of(context).primaryColor,)
                     ],
                  ):
                  CustomButton(
                      btnTxt: 'save'.tr,
                    onPressed: () => _updatePassword(controller)
                  ),
                ],
              ),
            );
          },
        )
      ),
    );
  }

  Widget customRichText(String title,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          children:[
            TextSpan(text: title,
              style: ubuntuRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
              ),
            ),
            TextSpan(text: ' *', style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error)),
          ],
        ),
      ),
    );
  }

  _updatePassword(ProfileController controller) {

    if(controller.passController!.text.isEmpty){
      showCustomSnackBar('enter_new_password'.tr);
    }else if (controller.passController!.text.length < 8) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (controller.confirmPassController!.text.isEmpty) {
      showCustomSnackBar('enter_confirm_password'.tr);
    } else if(controller.passController!.text != controller.confirmPassController!.text) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    }else {
      controller.updatePassword();
    }

  }
}
