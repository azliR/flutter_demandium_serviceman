import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';



class BookingHistorySectionMenu extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    Get.find<BookingHistoryController>();
    return GetBuilder<BookingHistoryController>(builder: (bookingHistoryController){
      return Container(
        color:  Theme.of(context).colorScheme.background,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: ListView.builder(
            itemCount: bookingHistoryController.bookingHistoryStatus.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
                return InkWell(
                  child: CategoryTabItem(
                      title: bookingHistoryController.bookingHistoryStatus[index].toLowerCase().tr,
                      index: index,
                  ),
                  onTap: (){
                    bookingHistoryController.updateIndex(index);
                    bookingHistoryController.getBookingHistory(bookingHistoryController.bookingHistoryStatus[index],1);
                  },
                );
            }),
      );
    });

  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}