import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class DialogImage extends StatelessWidget {
  const DialogImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      backgroundColor: Colors.transparent,
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white54),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                'take_a_picture'.tr, textAlign: TextAlign.center,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeLarge),

            GetBuilder<BookingDetailsController>(builder: (bookingDetailsController) {
              return InkWell(
                onTap: () {
                  Get.back();

                  Get.bottomSheet(const CameraButtonSheet());
                },
                child: Container(
                  height: 100, width: 150, alignment: Alignment.center, decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                  child:  Icon(Icons.camera_alt_sharp, color: Theme.of(context).primaryColor, size: 32),
                ),
              );
            }),

          ]),
        ),
      ]),
    );
  }
}