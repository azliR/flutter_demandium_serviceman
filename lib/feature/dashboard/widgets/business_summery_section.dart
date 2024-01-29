import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'dashboard_custom_card.dart';

class BusinessSummerySection extends StatelessWidget {
  const  BusinessSummerySection({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<DashboardController>(builder: (controller){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeDefault,
            ),
            child: Text(
              "bookings_summary".tr,
              style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          Container(
            padding:  const EdgeInsets.symmetric(
              horizontal:Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeSmall,
            ),
            width: MediaQuery.of(context).size.width,
            height: 260,
            decoration: BoxDecoration(
              color:Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
              boxShadow: shadow
            ),

            child: Column(
              children: [
                Row(
                  children:   [
                    BusinessSummaryItem(
                        height: 80,
                        curveColor: const Color(0xff7180ff),
                        cardColor: const Color(0xff6a79ff),
                        amount: controller.cards.pendingBookings ?? 0,
                        title: "total_assigned_booking".tr,
                        iconData: Images.earning
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    BusinessSummaryItem(
                      height: 80,
                      cardColor: const Color(0xff3376E0),
                      curveColor: const Color(0xff367ae3),
                      amount: controller.cards.ongoingBookings ?? 0,
                      title: "ongoing_booking".tr,
                      iconData: Images.service,
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                BusinessSummaryItem(
                  cardColor:Theme.of(context).colorScheme.surfaceTint,
                  amount: controller.cards.completedBookings ?? 0,
                  title: "total_completed_booking".tr,
                  iconData: Images.serviceMan,
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                BusinessSummaryItem(
                  cardColor: Theme.of(context).colorScheme.tertiary,
                  amount: controller.cards.canceledBookings ?? 0,
                  title: "total_canceled_booking".tr,
                  iconData: Images.booking,
                ),
              ],
            ),
          ),
        ],
      );
      }
    );
  }
}
