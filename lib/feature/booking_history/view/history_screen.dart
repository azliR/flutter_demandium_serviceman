import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);
  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar:  MainAppBar(title: 'booking_history'.tr,color: Theme.of(context).primaryColor),
        body: GetBuilder<BookingHistoryController>(
          builder: (bookingHistoryController){
            return RefreshIndicator(
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              onRefresh: () async{
                Get.find<BookingHistoryController>().getBookingHistory(
                    bookingHistoryController.bookingHistoryStatus[bookingHistoryController.currentIndex],1
                );
              },
              child:
              CustomScrollView(
               controller: bookingHistoryController.scrollController,
                slivers: [
                  SliverPersistentHeader(delegate: BookingHistorySectionMenu(),pinned: true,floating: false,),
                  bookingHistoryController.isFirst ?
                  const SliverToBoxAdapter(child: BookingHistoryShimmer()) :
                  bookingHistoryController.bookingList.isEmpty ?
                  SliverToBoxAdapter(
                      child: NoDataScreen(
                          text: '${'no'.tr} ${bookingHistoryController.bookingHistoryStatus[bookingHistoryController.currentIndex]=='All'?'booking'.tr.toLowerCase():
                          bookingHistoryController.bookingHistoryStatus[bookingHistoryController.currentIndex].toLowerCase().tr.toLowerCase()} ${"request_right_now".tr}'
                      )
                  ) :
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        bookingHistoryController.bookingList.isNotEmpty?
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: bookingHistoryController.bookingList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (con, index){
                              return BookingListItem(bookingItemModel: bookingHistoryController.bookingList[index]);
                            }):const SizedBox(),
                        bookingHistoryController.isLoading ? CircularProgressIndicator(color: Theme.of(context).primaryColor,):const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),  ///////
            );
          },
        )
    );
  }
}


