import 'package:demandium_serviceman/feature/dashboard/model/dashboard_model.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class RecentActivityItem extends StatelessWidget {
  final DashboardBooking activityData;
  const RecentActivityItem({
    Key? key, required this.activityData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              child: CustomImage(
                height: 70,
                width: 70,
                image: Get.find<SplashController>().configModel.content != null && activityData.detail![0].service != null ?
                "${Get.find<SplashController>().configModel.content!.imageBaseUrl!}"
                "${AppConstants.serviceImagePath}"
                "${activityData.detail![0].service!.thumbnail??""}" : "",
              ),
            ),

            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("booking".tr + "# ${activityData.readableId}".tr, maxLines: 1,
                    style: ubuntuBold.copyWith(fontWeight: FontWeight.w700, color: const Color(0xff758590))),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                  Text(textDirection: TextDirection.ltr,
                    DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(activityData.createdAt!)),
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: const Color(0xff758590)),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.fontSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:Get.isDarkMode?Colors.grey.withOpacity(0.2):
                ColorResources.buttonBackgroundColorMap[activityData.bookingStatus],
              ),
              child: Text(
                activityData.bookingStatus!.tr,
                style:ubuntuMedium.copyWith(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeSmall,
                    color: ColorResources.buttonTextColorMap[activityData.bookingStatus]
                ),
              ),
            ),
          ],
        ),
      );
    });
  }}