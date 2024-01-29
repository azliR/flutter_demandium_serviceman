import 'package:demandium_serviceman/common_model/service_details_model.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';


class ServiceCenterDialog extends StatefulWidget {
  final ServiceModel? service;
  final int selectedServiceIndex;
  const ServiceCenterDialog({super.key, this.service, required this.selectedServiceIndex});

  @override
  State<ServiceCenterDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ServiceCenterDialog> {

  @override
  void initState() {
    super.initState();
    Get.find<BookingEditController>().resetSelectedServiceVariationQuantity(widget.selectedServiceIndex);
  }

  @override
  Widget build(BuildContext context) {
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return PointerInterceptor(
      child: GetBuilder<BookingEditController>(builder: (bookingEditController){

        return Container(
          width:ResponsiveHelper.isDesktop(context)? Dimensions.webMaxWidth/2:Dimensions.webMaxWidth,
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
          ),
          child:  Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: Dimensions.paddingSizeLarge*2,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                  child: CustomImage(
                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${widget.service?.thumbnail}',
                    height: 60, width: 60,
                  ),
                ),
                Container( height: 40, width: 40, alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white70.withOpacity(0.6),
                      boxShadow:Get.isDarkMode ? null : [BoxShadow(color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1,)]
                  ),
                  child: InkWell( onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.black54,),
                  ),
                )
              ],
            ),

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Text( widget.service?.name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault), textAlign: TextAlign.center, maxLines: 2,),
            ),


            Text(
              "${widget.service?.variations?.length??"0"} ${'variation_available'.tr}",
              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
            ),

            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: Get.height * 0.1,
                  maxHeight: Get.height * 0.4
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.service?.variations?.length,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeExtraSmall,0,Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: shadow,
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault),),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${widget.service?.variations?[index].variantKey.toString().capitalizeFirst}".replaceAll('-', ' '), style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    maxLines: 2, overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text( PriceConverter.convertPrice(widget.service?.variations?[index].price,isShowLongPrice:true),
                                        style: ubuntuMedium.copyWith(color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded( flex:1,
                              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                widget.service!.variations![index].quantity > 0 ? InkWell(
                                  onTap: (){
                                    bookingEditController.updatedVariationQuantity(widget.selectedServiceIndex, index, increment: false);
                                  },
                                  child: Container(
                                    height: 30, width: 30,
                                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color:  Theme.of(context).colorScheme.secondary),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.remove , size: 15, color:Theme.of(context).cardColor,),
                                  ),
                                ) : const SizedBox(),

                                widget.service!.variations![index].quantity > 0 ? Text(
                                  widget.service!.variations![index].quantity.toString(),
                                ) : const SizedBox(),

                                GestureDetector(
                                  onTap: (){
                                    bookingEditController.updatedVariationQuantity(widget.selectedServiceIndex, index, increment: true);
                                  },
                                  child: Container(
                                    height: 30, width: 30,
                                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:  Theme.of(context).colorScheme.secondary
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add ,
                                      size: 15,
                                      color:Theme.of(context).cardColor,
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ]),
                        ),
                      ),
                    );
                  }),
            ),

            CustomButton(
              height: ResponsiveHelper.isDesktop(context) ? 55 : 45,
              onPressed: bookingEditController.isCartButtonActive? () async {
                await bookingEditController.addMultipleCartItem(widget.selectedServiceIndex);
                Get.back();
              } : null,
              btnTxt: 'add_to_cart'.tr,
              isLoading: bookingEditController.isLoading ,
            ),
          ],
          ),
        );
      }),
    );
  }
}

