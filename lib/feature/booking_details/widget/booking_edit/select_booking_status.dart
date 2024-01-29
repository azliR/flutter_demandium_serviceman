import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class BookingStatusDropdown extends StatelessWidget {
  const BookingStatusDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<BookingEditController>(builder: (bookingEditController){
      return Container(width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(color: Theme.of(context).disabledColor,width: 1)
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              dropdownColor: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5),
              elevation: 2,
              hint: Text(bookingEditController.selectedBookingStatus ==''?
              "select_identity_type".tr : "${'booking_status'.tr} : ${bookingEditController.selectedBookingStatus.tr}",
                style: ubuntuRegular.copyWith(
                    color: bookingEditController.selectedBookingStatus ==''?
                    Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):
                    Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: bookingEditController.statusTypeList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Row(
                    children: [
                      Text(items.tr,
                        style: ubuntuRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) => bookingEditController.changeBookingStatusDropDownValue(newValue!)
          ),
        ),
      );
    });
  }
}
