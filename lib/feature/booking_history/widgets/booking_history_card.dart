import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';



class BookingListItem extends StatelessWidget {
  final BookingItemModel bookingItemModel;
  const BookingListItem({Key? key, required this.bookingItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.toNamed(RouteHelper.getBookingDetailsRoute(bookingItemModel.id!,"","others")),
      child: Padding(
        padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
            boxShadow: shadow
          ),
          margin: const EdgeInsets.only(bottom: 3),
          padding:  const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeSmall,
            horizontal: Dimensions.paddingSizeDefault,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("booking".tr, style: ubuntuMedium,),
                        Text(" # ${bookingItemModel.readableId}", overflow: TextOverflow.ellipsis, style: ubuntuBold,),
                      ],
                    ),
                     const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                     bookingDate("${'booking_date'.tr} : ",bookingItemModel.createdAt!),
                     const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                    Row(
                      children: [
                        Text("${"service_scheduled_date".tr} : ",
                          style: ubuntuRegularLow.copyWith(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        Text(
                          textDirection: TextDirection.ltr,
                          DateConverter.dateMonthYearTime(DateTime.tryParse(bookingItemModel.serviceSchedule!,),),
                          style: ubuntuRegularLow.copyWith(color: Theme.of(context).secondaryHeaderColor,),
                        ),
                      ],
                    ),
                     const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Row(
                      children: [
                        Text(
                          "${"total_amount".tr}: ",
                          style: ubuntuMediumMid.copyWith(color: Theme.of(context).primaryColor),
                        ),

                        Text(
                          PriceConverter.convertPrice(bookingItemModel.totalBookingAmount!.toDouble()),
                          style: ubuntuMediumMid.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: 5
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Get.isDarkMode ?
                      Colors.grey.withOpacity(0.2) :
                      ColorResources.buttonBackgroundColorMap[bookingItemModel.bookingStatus],
                    ),
                    child: Center(
                      child: Text(
                        bookingItemModel.bookingStatus!.tr,
                        style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: ColorResources.buttonTextColorMap[bookingItemModel.bookingStatus],
                        ),
                      ),
                    ),
                  ),
                  Gaps.verticalGapOf(Dimensions.paddingSizeExtraLarge),

                  Text("view_details".tr,
                    style: ubuntuRegularLow.copyWith(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bookingDate(String dateType,String date){
  return Builder(
    builder: (context) {
      return Row(
        children: [
          Text(dateType, style: ubuntuRegularLow.copyWith(color: Theme.of(context).secondaryHeaderColor)),
          Text(
            textDirection: TextDirection.ltr,
            DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(date)),
            style: ubuntuRegularLow.copyWith(color: Theme.of(context).secondaryHeaderColor)
          ),
        ],
      );
    }
  );
}






