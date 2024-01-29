import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class BookingDetailsCustomerInfo extends StatelessWidget {
  const BookingDetailsCustomerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BookingDetailsController>(
        builder: (bookingDetailsController) {
          final bookingDetails =bookingDetailsController.bookingDetailsContent;
          return Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
              child: Text("customer_info".tr,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
              ),
            ),


            BottomCard(
              name: "${bookingDetails?.customer?.firstName?? bookingDetails?.serviceAddress?.contactPersonName??""} ${bookingDetailsController.bookingDetailsContent?.customer?.lastName??""}",
              phone:  bookingDetails?.serviceAddress?.contactPersonNumber?? bookingDetails?.customer?.phone?? bookingDetails?.customer?.email??"",

              image: "${Get.find<SplashController>().configModel.content?.imageBaseUrl}${AppConstants.customerProfileImagePath}"
                  "${bookingDetails?.customer?.profileImage??""}",
              address: bookingDetails?.serviceAddress?.address??'address_not_found'.tr,
            )
          ]);
        });
  }
}
