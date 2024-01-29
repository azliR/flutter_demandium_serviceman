import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'menu_status.dart';

class BookingListMenu extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    Get.find<BookingListController>();

    return GetBuilder<BookingListController>(builder: (bookingListController){
      return Container(
        color:  Theme.of(context).colorScheme.background,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeSmall,
          horizontal: Dimensions.paddingSizeSmall,
        ),
        child: ListView.builder(
          itemCount: BooingListStatus.values.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){

            return GetBuilder<BookingListController>(builder: (bookingListController){
              return InkWell(
                child: BookingMenuItem(
                    title: BooingListStatus.values.elementAt(index).name.toLowerCase().tr, index: index),
                onTap: () => bookingListController.updateBookingStatusState(BooingListStatus.values.elementAt(index)),
              );
            });
          }
        ),
      );
    });
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate){
    return true;
  }

}