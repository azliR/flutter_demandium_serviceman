
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';



class StatusChangeDropdownButton extends StatelessWidget {
  final String bookingId;
  const StatusChangeDropdownButton({Key? key, required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeSmall),
        height: 70,
        child: bookingDetailsController.dropDownValue == "completed" && bookingDetailsController.showPhotoEvidenceField && Get.find<SplashController>().configModel.content?.bookingOtpVerification == 1?
        CustomButton(btnTxt: "request_for_otp".tr, onPressed: () {
          bookingDetailsController.sendBookingOTPNotification(bookingId, shouldUpdate: false);
          Get.bottomSheet( VerifyDeliverySheet(bookingId: bookingId));
        },) :
        Row(children: [
          Expanded(
            child: Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge), height: 45,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Get.isDarkMode? light.cardColor.withOpacity(0.3):
                  Theme.of(context).primaryColor.withOpacity(0.30)
                  )
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: bookingDetailsController.dropDownValue == ''?
                  Text(bookingDetailsController.bookingDetailsContent!.bookingStatus!.tr) :
                  Text(bookingDetailsController.dropDownValue.tr),
                  dropdownColor: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(5),
                  elevation: 2,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: bookingDetailsController.statusTypeList.map((String items) {
                    return DropdownMenuItem(value: items, child: Row(children: [Text(items.tr)]));
                  }).toList(),
                  onChanged:(String? newValue) {
                    bookingDetailsController.setSelectedValue(newValue!);

                    if(newValue=="completed"){

                      if(Get.find<SplashController>().configModel.content?.bookingImageVerification == 1 && bookingDetailsController.pickedPhotoEvidence.isNotEmpty){
                        bookingDetailsController.changePhotoEvidenceStatus(status: true);
                      }else if(Get.find<SplashController>().configModel.content?.bookingOtpVerification == 1) {
                        bookingDetailsController.changePhotoEvidenceStatus(status: true);
                      }else{
                        bookingDetailsController.changePhotoEvidenceStatus(status: false);
                      }

                      if(Get.find<SplashController>().configModel.content?.bookingImageVerification == 0 && Get.find<SplashController>().configModel.content?.bookingOtpVerification == 0){
                        Get.bottomSheet(PaymentReceiveDialog(bookingDetailsController.bookingDetailsContent!.id!,bookingDetailsController.bookingDetailsContent!.totalBookingAmount.toString()));
                      }else{
                        if(Get.find<SplashController>().configModel.content?.bookingImageVerification == 1  && bookingDetailsController.pickedPhotoEvidence.isEmpty){
                          Get.dialog(const DialogImage(), barrierDismissible: false);
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width:Dimensions.paddingSizeDefault),
          bookingDetailsController.isUpdate ?
          SizedBox(height: 45,width: 112,
              child:Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor))
          ) : CustomButton(
            height: 45,width: 112,
            btnTxt:"change".tr,
            onPressed: bookingDetailsController.bookingDetailsContent!.bookingStatus == "canceled"
                || bookingDetailsController.bookingDetailsContent!.bookingStatus == "completed"
                || bookingDetailsController.bookingDetailsContent!.bookingStatus == bookingDetailsController.dropDownValue? null
                : (){
              bookingDetailsController.changeBookingStatus(
                bookingDetailsController.bookingDetailsContent!.id.toString(),
                bookingDetailsController.bookingDetailsContent!.bookingStatus!,
              );},
          )
        ]),
      );
    });
  }
}
