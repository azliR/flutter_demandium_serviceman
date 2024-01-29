import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class BookingInformationView extends StatelessWidget {
  const BookingInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      final bookingDetails =bookingDetailsController.bookingDetailsContent;
      return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          const SizedBox(height:Dimensions.paddingSizeDefault),
          BookingItem(
            img: Images.iconCalendar,
            title: '${'booking_date'.tr} : ',
            date: DateConverter.dateMonthYearTime(
                DateConverter.isoUtcStringToLocalDate(bookingDetails!.createdAt!)),
          ),
          const SizedBox(height:Dimensions.paddingSizeSmall),

          BookingItem(
            img: Images.iconCalendar,
            title: '${'schedule_date'.tr} : ',
            date: ' ${DateConverter.dateMonthYearTime(DateTime.tryParse(bookingDetails.serviceSchedule!))}',
          ),
          const SizedBox(height:Dimensions.paddingSizeSmall),

          BookingItem(
            img: Images.iconLocation,
            title: '${'service_address'.tr} : ${bookingDetails.serviceAddress !=null?''
                '${bookingDetails.serviceAddress!.address}'
                :'address_not_found'.tr
            }',
            date: '',
          ),
          const SizedBox(height:Dimensions.paddingSizeDefault),
          Text("payment_method".tr,
            style: ubuntuBold.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          const SizedBox(height:Dimensions.paddingSizeExtraSmall),

          Text("${bookingDetails.paymentMethod!.tr} ${ bookingDetails.partialPayments !=null  && bookingDetails.partialPayments!.isNotEmpty ? "&_wallet_balance".tr: ""}",
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5))),
          const SizedBox(height:Dimensions.paddingSizeExtraSmall),

          (bookingDetails.paymentMethod !="cash_after_service" && bookingDetails.paymentMethod !="offline_payment") ?
          Padding(padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeExtraSmall),
            child: Text("${'transaction_id'.tr} : ${bookingDetails.transactionId}",
              style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).hintColor,
              ),
            ),
          ):const SizedBox.shrink(),

          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
            child: RichText(
              text: TextSpan(text: "${'payment_status'.tr} : ",
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                children: <TextSpan>[
                  TextSpan(
                    text: bookingDetails.partialPayments != null && bookingDetails.partialPayments!.isNotEmpty && bookingDetails.isPaid == 0 ? "partially_paid".tr :  bookingDetails.isPaid == 0 ? "unpaid".tr : "paid".tr,
                    style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: bookingDetails.partialPayments != null && bookingDetails.partialPayments!.isNotEmpty && bookingDetails.isPaid == 0 ? Theme.of(context).primaryColor : bookingDetails.isPaid == 0 ?
                      Theme.of(context).colorScheme.error: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ),

          Row(
            children: [
              Text("${'amount'.tr} : ",
                style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                ),
              ),

              Text(PriceConverter.convertPrice(bookingDetails.totalBookingAmount ?? 0,isShowLongPrice:true),
                style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}