import 'package:demandium_serviceman/feature/location/widget/permission_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'booking_summery_widget.dart';

class BookingDetailsWidget extends StatefulWidget{
  const BookingDetailsWidget({Key? key}) : super(key: key);

  @override
  State<BookingDetailsWidget> createState() => _BookingDetailsWidgetState();
}

class _BookingDetailsWidgetState extends State<BookingDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController){
        bool showDeliveryConfirmImage = bookingDetailsController.showPhotoEvidenceField;
        ConfigModel configModel = Get.find<SplashController>().configModel;
      return bookingDetailsController.bookingDetailsContent == null ?
        SizedBox(
            height: Get.height * 0.8,
            child:Center(
                child: CircularProgressIndicator(color: Theme.of(context).hoverColor)
            )
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SingleChildScrollView(
              controller: bookingDetailsController.scrollController,
              child: Column(
                children: [
                  const SizedBox(height:Dimensions.paddingSizeSmall),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                      boxShadow: shadow,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeSmall),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${"booking".tr} # ${bookingDetailsController.bookingDetailsContent!.readableId}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: ubuntuMediumHigh.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)
                                ),
                                Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
                                (bookingDetailsController.bookingDetailsContent?.bookingStatus!="canceled")?
                                GestureDetector(
                                  onTap: () async {
                                    _checkPermission(() async {
                                      if(bookingDetailsController.bookingDetailsContent!.serviceAddress!=null){
                                        Get.dialog(const CustomLoader(),barrierDismissible: false);
                                        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
                                          MapUtils.openMap(
                                              double.tryParse(bookingDetailsController.bookingDetailsContent!.serviceAddress!.lat!) ?? 23.8103,
                                              double.tryParse(bookingDetailsController.bookingDetailsContent!.serviceAddress!.lon!) ?? 90.4125,
                                              position.latitude ,
                                              position.longitude);
                                        });
                                        Get.back();
                                      }else{
                                        showCustomSnackBar("service_address_not_found".tr);
                                      }
                                    });
                                   },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeDefault,
                                        vertical: Dimensions.paddingSizeExtraSmall+2
                                    ),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                        color:Colors.grey.withOpacity(0.2)
                                    ),
                                    child: Center(
                                      child: Text("view_on_map".tr,
                                        style:ubuntuMediumLow.copyWith(
                                          color: ColorResources.buttonTextColorMap['accepted'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ): Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeDefault,
                                      vertical: Dimensions.paddingSizeExtraSmall
                                  ),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                      color:Colors.grey.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    child: Text("canceled".tr,
                                      style:ubuntuMediumLow.copyWith(
                                        color: ColorResources.buttonTextColorMap['canceled'],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if(configModel.content?.serviceManCanEditBooking == 1 && bookingDetailsController.providerServicemanCanEditBooking == 1)
                            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                              child: CustomButton(height: 35,btnTxt: "edit_booking".tr, icon: Icons.edit,
                                onPressed: (configModel.content?.serviceManCanEditBooking == 1 && bookingDetailsController.providerServicemanCanEditBooking == 1
                                    && (bookingDetailsController.bookingDetailsContent?.bookingStatus == "accepted" || bookingDetailsController.bookingDetailsContent?.bookingStatus == "ongoing")
                                    && (bookingDetailsController.bookingDetailsContent?.partialPayments!=null && bookingDetailsController.bookingDetailsContent!.partialPayments!.isEmpty)
                                    && (bookingDetailsController.bookingDetailsContent?.isGuest == 1 && bookingDetailsController.bookingDetailsContent?.paymentMethod != "cash_after_service" ? false : true))  ? (){
                                Get.to(()=> const BookingEditScreen());
                              }: null,fontSize: Dimensions.fontSizeSmall
                                ,),
                            )),

                            Column(
                              children: [
                                CustomButton(
                                  height: 35,
                                  width: 75,
                                  fontSize: Dimensions.fontSizeSmall,
                                  btnTxt: "invoice".tr,
                                  onPressed: () async {
                                    Get.dialog(const CustomLoader(), barrierDismissible: false);
                                    var pdfFile = await PdfInvoiceApi.generate(
                                        bookingDetailsController.bookingDetailsContent!,
                                        bookingDetailsController.invoiceItems,
                                        bookingDetailsController
                                    );
                                    Get.back();
                                    PdfApi.openFile(pdfFile);
                                  },
                                ),
                              ],
                            )
                          ]
                        ),
                        if(bookingDetailsController.bookingDetailsContent?.bookingStatus!="canceled")
                        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                          child: RichText(text:  TextSpan(text: '${'booking_status'.tr}:   ',
                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault-1,
                                color:Theme.of(context).textTheme.bodyLarge!.color,),
                              children: [
                                TextSpan(text: bookingDetailsController.bookingDetailsContent!.bookingStatus!.tr,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault-1,
                                        color: ColorResources.buttonTextColorMap[bookingDetailsController.bookingDetailsContent!.bookingStatus],
                                        decoration: TextDecoration.none)
                                ),
                              ]),
                          ),
                        ),

                        const BookingInformationView(),

                      ],
                    ),
                  ),

                  BookingSummeryView(bookingDetailsContent: bookingDetailsController.bookingDetailsContent!),

                  const BookingDetailsProviderInfo(),

                  const BookingDetailsCustomerInfo(),


                  bookingDetailsController.bookingDetailsContent?.photoEvidence != null &&  bookingDetailsController.bookingDetailsContent!.photoEvidence!.isNotEmpty ?
                  Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Text('completed_service_picture'.tr,  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: ListView.builder(
                          controller: bookingDetailsController.completedServiceImagesScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount:  bookingDetailsController.bookingDetailsContent?.photoEvidence?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                child: GestureDetector(
                                  onTap: () => showDialog(context: context, builder: (ctx)  =>
                                      NotificationDialog(
                                        imageUrl:"${Get.find<SplashController>().configModel.content?.imageBaseUrl}/booking/evidence/${bookingDetailsController.bookingDetailsContent?.photoEvidence?[index]??""}",
                                        title: "completed_service_picture".tr,
                                        subTitle: "",
                                      )
                                  ),
                                  child: CustomImage(
                                    image: "${Get.find<SplashController>().configModel.content?.imageBaseUrl}/booking/evidence/${bookingDetailsController.bookingDetailsContent?.photoEvidence?[index]??""}",
                                    height: 70, width: 120,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ):
                  const SizedBox(),

                  Get.find<SplashController>().configModel.content?.bookingImageVerification == 1 && showDeliveryConfirmImage && bookingDetailsController.bookingDetailsContent?.bookingStatus != 'completed' ? Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('completed_service_picture'.tr,  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: bookingDetailsController.pickedPhotoEvidence.length+1,
                          itemBuilder: (context, index) {
                            XFile? file = index == bookingDetailsController.pickedPhotoEvidence.length ? null : bookingDetailsController.pickedPhotoEvidence[index];
                            if(index < 5 && index == bookingDetailsController.pickedPhotoEvidence.length) {
                              return InkWell(
                                onTap: () {
                                  Get.bottomSheet(const CameraButtonSheet());
                                },
                                child: Container(
                                  height: 60, width: 70, alignment: Alignment.center, decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                ),
                                  child:  Icon(Icons.camera_alt_sharp, color: Theme.of(context).primaryColor, size: 32),
                                ),
                              );
                            }
                            return file != null ? Container(
                              margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              ),
                              child: Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  child: GetPlatform.isWeb ? Image.network(
                                    file.path, width: 120, height: 70, fit: BoxFit.cover,
                                  ) : Image.file(
                                    File(file.path), width: 120, height: 70, fit: BoxFit.cover,
                                  ),
                                ),
                              ]),
                            ) : const SizedBox();
                          },
                        ),
                      ),
                    ]),
                  ) : const SizedBox(),

                  const SizedBox(height:Dimensions.paddingSizeExtraLarge),
                ],
              ),
            ),),
            bookingDetailsController.bookingDetailsContent?.bookingStatus == "accepted" ||  bookingDetailsController.bookingDetailsContent?.bookingStatus == "ongoing" ?
            SafeArea(child: StatusChangeDropdownButton(bookingId: bookingDetailsController.bookingDetailsContent?.id??"",)): const SizedBox(),
          ],
      );
      },
    );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(const PermissionDialog());
    }else {
      onTap();
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double destinationLatitude, double destinationLongitude, double userLatitude, double userLongitude) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}








