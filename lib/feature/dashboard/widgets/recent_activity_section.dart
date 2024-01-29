import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault+3,
                vertical: Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(Images.dashboardProfile,height: 15,width: 15,),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      "my_recent_activities".tr,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),
                  ],
                ),
              ],
            ),
          ),
          dashboardController.bookings.isEmpty?
          Container(
            padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall),

            child: Center(
              child: Text(
                'your_recent_booking_will_appear_here'.tr,
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,

                ),
              ),
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
              boxShadow: shadow,
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      child: RecentActivityItem(activityData: dashboardController.bookings[index]),
                      onTap: (){
                        Get.toNamed(RouteHelper.getBookingDetailsRoute(dashboardController.bookings[index].id!,'','others'));
                        },
                    ),
                    if(index!=dashboardController.bookings.length-1) const Divider()
                  ],
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dashboardController.bookings.length,
            ),
          ),
        ],
      );
    });
  }
}
