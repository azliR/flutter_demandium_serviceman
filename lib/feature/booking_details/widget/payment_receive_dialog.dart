import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class PaymentReceiveDialog extends StatefulWidget {
  final String bookingId;
  final String orderAmount;
  const PaymentReceiveDialog(this.bookingId, this.orderAmount, {super.key});

  @override
  State<PaymentReceiveDialog> createState() => _PaymentReceiveDialogState();
}

class _PaymentReceiveDialogState extends State<PaymentReceiveDialog>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Container(
        width: Dimensions.webMaxWidth,
        padding: const EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: GetBuilder<BookingDetailsController>(
            builder: (bookingDetailsController) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () => Get.back(),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: Dimensions.paddingSizeDefault,
                                right: Dimensions.paddingSizeDefault),
                            child: Icon(Icons.close),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          right: Dimensions.paddingSizeDefault,
                          top: ResponsiveHelper.isDesktop(context)
                              ? 0
                              : Dimensions.paddingSizeDefault,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.asset(Images.money),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                              Text("collected_money_from_customer".tr,style: ubuntuBold,),
                              const SizedBox(height: Dimensions.paddingSizeLarge,),

                              Row( crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${"order_amount".tr} : ',style: ubuntuBold,),
                                  Text(PriceConverter.convertPrice(double.parse(widget.orderAmount)),style: ubuntuBold,),
                                ],),
                              const SizedBox(height: Dimensions.paddingSizeLarge,),


                              CustomButton(
                                onPressed:(){
                                  bookingDetailsController.changePaymentStatus(widget.bookingId,"paid");
                                  bookingDetailsController.changeBookingStatus(widget.bookingId, "completed");
                                  Get.back();
                                },
                                btnTxt: 'ok'.tr,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeLarge),
                            ]),
                      ),
                    ]),
              );
            }),
      ),
    );
  }
}
