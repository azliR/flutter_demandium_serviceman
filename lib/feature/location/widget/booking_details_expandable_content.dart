import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class BookingDetailsExpandableContent extends StatelessWidget {
  final BookingDetailsContent? bookingDetailsContent;
  const BookingDetailsExpandableContent({Key? key, required this.bookingDetailsContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius :  const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeExtraLarge),
              topRight : Radius.circular(Dimensions.paddingSizeExtraLarge)),
          boxShadow: [BoxShadow(color: Get.isDarkMode ? Colors.grey[900]! :Colors.grey[300]!, blurRadius: 5, spreadRadius: 1, offset: const Offset(0,2))]
      ),
      width: MediaQuery.of(context).size.width,

      child: Column(children: [
        const SizedBox(height: Dimensions.paddingSizeLarge,),

        Container(
          height: 5,width: Get.width*0.15,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
          ),
        ),

        Padding(
          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: Text('${'booking'.tr} # ${bookingDetailsContent?.readableId??""}',style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme.of(context).colorScheme.secondary)),
        ),

        Divider(height: .75,color: Theme.of(context).primaryColor.withOpacity(.725)),

        Padding(
          padding: const  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: TrackingStepperWidget(status: "${bookingDetailsContent?.bookingStatus}"),
        ),

        const BookingDetailsCustomerInfo(),
        const SizedBox(height: Dimensions.paddingSizeLarge,)
      ],),

    );
  }
}
