import 'package:demandium_serviceman/core/core_export.dart';
import 'package:demandium_serviceman/feature/booking_details/widget/custom_stpper.dart';
import 'package:get/get.dart';

class TrackingStepperWidget extends StatelessWidget {
  final String? status;

  const TrackingStepperWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int statusValue = -1;

    if(status == 'accepted') {
      statusValue = 0;
    }else if(status == 'ongoing') {
      statusValue = 1;
    }else if(status == 'completed') {
      statusValue = 2;
    }

    return Container(
      padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.15) :Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
      ),
      child: Row(children: [
        CustomStepper(
          title: 'accepted'.tr, isActive: statusValue > -1, haveLeftBar: false, haveRightBar: true, rightActive: statusValue > 0,
          icon: Images.approvedIcon,
        ),
        CustomStepper(
          title: 'ongoing'.tr, isActive: statusValue > 0, haveLeftBar: true, haveRightBar: true, rightActive: statusValue > 1,
          icon: Images.ongoingIcon,
        ),
        CustomStepper(
          title: 'completed'.tr, isActive: statusValue > 1, haveLeftBar: true, haveRightBar: false, rightActive: statusValue > 2,
          icon: Images.completedIcon,
        ),

      ]),
    );
  }
}