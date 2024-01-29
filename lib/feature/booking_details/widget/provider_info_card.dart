import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class BookingDetailsProviderInfo extends StatelessWidget {
  const BookingDetailsProviderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      return Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [

        Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault , vertical: Dimensions.paddingSizeDefault),
          child: Text("provider_info".tr,style:ubuntuMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight) ,
          ),
        ),


        BottomCard(
          name: bookingDetailsController.bookingDetailsContent!.provider!.companyName!,
          phone: bookingDetailsController.bookingDetailsContent!.provider!.companyPhone!,
          image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl!}"
              "${AppConstants.providerProfileImagePath}"
              "${bookingDetailsController.bookingDetailsContent!.provider!.logo!}",
        ),

      ]);
    });
  }
}
