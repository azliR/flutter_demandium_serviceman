import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class VerifyDeliverySheet extends StatefulWidget {
  final String? bookingId;

  const VerifyDeliverySheet({Key? key, this.bookingId}) : super(key: key);

  @override
  State<VerifyDeliverySheet> createState() => _VerifyDeliverySheetState();
}

class _VerifyDeliverySheetState extends State<VerifyDeliverySheet> {
  @override
  void initState() {
    super.initState();
    Get.find<BookingDetailsController>().setOtp('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: GetBuilder<BookingDetailsController>(builder: (bookingDetailsController) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Container(
              height: 5, width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                color: Theme.of(context).disabledColor.withOpacity(0.5),
              ),
            ),

            Column(children: [
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Text('otp_verification'.tr, style: ubuntuBold, textAlign: TextAlign.center),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Text('enter_otp_number'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).disabledColor), textAlign: TextAlign.center),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              SizedBox(
                width: 260,
                child: PinCodeTextField(
                  length: 6,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 30,
                    fieldWidth: 30,
                    borderWidth: 2,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    selectedColor: Theme.of(context).primaryColor,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Theme.of(context).cardColor,
                    inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor: Theme.of(context).primaryColor.withOpacity(0.7),
                    activeFillColor: Theme.of(context).cardColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: (String text) => bookingDetailsController.setOtp(text),
                  beforeTextPaste: (text) => true,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text('collect_otp_from_customer'.tr, style: ubuntuRegular, textAlign: TextAlign.center),
              const SizedBox(height: Dimensions.paddingSizeLarge),

            ]) ,

            !bookingDetailsController.isUpdate ? CustomButton(
              btnTxt:  'submit'.tr,
              radius: Dimensions.radiusDefault,
              margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              onPressed: (bookingDetailsController.otp.length != 6) ? null : () async {
                bookingDetailsController.changeBookingStatus( widget.bookingId!, "completed", isBack: true);
              },
            ) : const Padding( padding: EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: Center(child: CircularProgressIndicator()),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'did_not_get_any_OTP'.tr,
                style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),
              ),
              bookingDetailsController.hideResendButton ?  Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: SizedBox(height: Dimensions.fontSizeLarge, width:  Dimensions.fontSizeLarge, child: const CircularProgressIndicator(),),
              ) : InkWell(
                onTap: () => bookingDetailsController.sendBookingOTPNotification(widget.bookingId),
                child: Text(
                  'resend_it'.tr,
                  style: ubuntuMedium.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),
                ),
              )
            ]),

            const SizedBox(height: Dimensions.paddingSizeLarge),
          ]),
        );
      }),
    );
  }
}
