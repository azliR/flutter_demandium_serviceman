// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class BookingDetails extends StatefulWidget{
  final String bookingId;
  final String bookingStatus;
  final String? fromPage;
  final String subcategoryId;
  const BookingDetails( {
    Key? key,required this.bookingId,
    required this.bookingStatus,
    this.fromPage,
    required this.subcategoryId
  }) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}
class _BookingDetailsState extends State<BookingDetails> with SingleTickerProviderStateMixin {

  TabController? controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(vsync: this, length: 2);
    Get.find<BookingDetailsController>().getBookingDetailsData(widget.bookingId);
    Get.find<BookingDetailsController>().pickPhotoEvidence(isRemove:true, isCamera: false);

    controller?.addListener(() {
      if(controller?.index == 0){
        Get.find<BookingDetailsController>().updateServicePageCurrentState(
            BookingDetailsTabControllerState.bookingDetails
        );
      }else{
        Get.find<BookingDetailsController>().updateServicePageCurrentState(
            BookingDetailsTabControllerState.status
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
        builder: (bookingDetailsController){

          bool showChattingButton = ( (bookingDetailsController.bookingDetailsContent != null) && (bookingDetailsController.bookingDetailsContent?.bookingStatus == "pending"
              || bookingDetailsController.bookingDetailsContent?.bookingStatus == "accepted" || bookingDetailsController.bookingDetailsContent?.bookingStatus == "ongoing" )
              && (bookingDetailsController.bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails)
              && (bookingDetailsController.bookingDetailsContent!.serviceman !=null || bookingDetailsController.bookingDetailsContent!.customer != null));

          return WillPopScope(
            onWillPop: () async {
              if(widget.fromPage == 'fromNotification') {
                Get.offAllNamed(RouteHelper.getInitialRoute());
                return false;

              }else {
                return true;
              }
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar:AppBar(
                elevation: 5,
                titleSpacing: 0,
                backgroundColor: Theme.of(context).colorScheme.background,
                shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
                title: Text('booking_details'.tr,
                  style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),
                ),
                leading: IconButton(onPressed: (){
                  if(widget.fromPage == 'fromNotification'){
                    Get.offAllNamed(RouteHelper.getInitialRoute());
                  }else{
                    Get.back();
                  }
                },
                  icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
                ),
              ),
              body:DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      width: Get.width,
                      color: Theme.of(context).colorScheme.background,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.0),
                          border:  Border(
                            bottom: BorderSide(
                                color: Theme.of(context).primaryColor.withOpacity(0.7), width: 0.5),
                          ),
                        ),
                        child: Center(
                          child: TabBar(
                            isScrollable: false,
                            unselectedLabelColor:Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                            indicatorColor: Theme.of(context).primaryColor,
                            controller: controller,
                            labelColor: Theme.of(context).primaryColorLight,
                            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                            onTap: (int? index) {
                              switch (index) {
                                case 0:
                                  bookingDetailsController.updateServicePageCurrentState(
                                      BookingDetailsTabControllerState.bookingDetails
                                  );
                                  break;
                                case 1:
                                  bookingDetailsController.updateServicePageCurrentState(
                                      BookingDetailsTabControllerState.status
                                  );
                                break;
                              }
                            },
                            tabs: [
                              Tab(text: 'booking_details'.tr),
                              Tab(text: 'status'.tr),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: TabBarView(
                        controller: controller,
                        children: const [
                          BookingDetailsWidget(),
                          BookingStatus(),
                        ],
                      )
                    ),
                  ],
                ),
              ),
                floatingActionButton:  showChattingButton ?
              Container(
                padding: const EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: ()=> Get.bottomSheet( CreateChannelDialog(
                    customerID: Get.find<BookingDetailsController>().bookingDetailsContent!.customerId,
                    providerId: Get.find<BookingDetailsController>().bookingDetailsContent!.provider!.userId!,
                    serviceManId: Get.find<BookingDetailsController>().bookingDetailsContent!.serviceman!.userId!,
                    referenceId: Get.find<BookingDetailsController>().bookingDetailsContent!.id!,),
                  ),
                  child: Icon(Icons.message_rounded,color: light.cardColor,),
                ),
              ): null
            ),
          );
      },
    );
  }
}

