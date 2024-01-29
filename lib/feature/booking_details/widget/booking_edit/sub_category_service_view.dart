import 'package:demandium_serviceman/common_model/service_details_model.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';



class SubcategoryServiceView extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;
  final List<ServiceModel> serviceList;
  const SubcategoryServiceView({Key? key, required this.categoryId, required this.subCategoryId, required this.serviceList}) : super(key: key);

  @override
  State<SubcategoryServiceView> createState() => _SubcategoryServiceViewState();
}

class _SubcategoryServiceViewState extends State<SubcategoryServiceView>  with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return pointerInterceptor();
  }
  pointerInterceptor(){
    return PointerInterceptor(
      child: Container(
        height: Get.height/1.7,
        width:ResponsiveHelper.isDesktop(context)? Dimensions.webMaxWidth/1.5:Dimensions.webMaxWidth,
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
        ),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start, children: [

            Center(child: Container(height: 5,width: 90,decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.fontSizeDefault),
              color: Theme.of(context).hintColor,
            ),)),
            const SizedBox(height: Dimensions.paddingSizeDefault,),

            GetBuilder<BookingEditController>(builder: (bookingEditController){

              if(widget.serviceList.isEmpty){
                return SizedBox( height: Get.height/2, child: NoDataScreen(text: 'no_services_found'.tr,type: NoDataType.others,));
              }else if(widget.serviceList.isNotEmpty){
                return Padding(padding: EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeDefault,
                  bottom:  Dimensions.paddingSizeDefault,
                ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge,),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.serviceList.length,
                      itemBuilder: (context, index) {
                        final discountModel = PriceConverter.discountCalculation(widget.serviceList[index]);
                        num lowestPrice = 0.0;
                        if(widget.serviceList[index].variations != null){
                          lowestPrice = widget.serviceList[index].variations ![0].price!;
                          for (var i = 0; i < widget.serviceList[index].variations !.length; i++) {
                            if (widget.serviceList[index].variations ![i].price! < lowestPrice) {
                              lowestPrice = widget.serviceList[index].variations ![i].price!;
                            }
                          }
                        }
                        return GestureDetector(
                          onTap: (){
                            Get.back();
                            showModalBottomSheet(
                                useRootNavigator: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context, builder: (context) => ServiceCenterDialog(service: widget.serviceList[index],selectedServiceIndex: index,));
                          },
                          child: Padding(
                            padding:  const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  boxShadow: Get.find<ThemeController>().darkTheme? [const BoxShadow()]: [BoxShadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.05),
                                  )],
                                  color: Theme.of(context).cardColor
                              ),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    child: CustomImage(height: 90, width: 90, fit: BoxFit.cover,
                                        image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/service/"
                                            "${widget.serviceList[index].thumbnail}")),

                                const SizedBox(width: Dimensions.paddingSizeDefault,),
                                Expanded(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                    Text( widget.serviceList[index].name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: Dimensions.paddingSizeSmall),
                                    Text("start_form".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),),
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(discountModel.discountAmount! > 0)
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              PriceConverter.convertPrice(lowestPrice.toDouble()),
                                              maxLines: 2,
                                              style: ubuntuRegular.copyWith(
                                                  fontSize: Dimensions.fontSizeLarge,
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Theme.of(context).colorScheme.error.withOpacity(.8)),),
                                          ),
                                        discountModel.discountAmount! > 0?
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                            PriceConverter.convertPrice(
                                                lowestPrice.toDouble(),
                                                discount: discountModel.discountAmount!.toDouble(),
                                                discountType: discountModel.discountAmountType),
                                            style: ubuntuMedium.copyWith(
                                                fontSize: Dimensions.paddingSizeDefault,
                                                color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                          ),
                                        ): Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text( PriceConverter.convertPrice(lowestPrice.toDouble()),
                                            style: ubuntuMedium.copyWith(fontSize:Dimensions.fontSizeLarge,
                                              color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],),
                                )
                              ],),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                  ]),
                );
              }else{
                return  GridView.builder(
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.paddingSizeLarge,
                    mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
                    crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 1,
                    mainAxisExtent: ResponsiveHelper.isMobile(context) ? 115 : 120,
                  ),
                  itemCount: 6,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge,top: Dimensions.paddingSizeDefault),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder:(BuildContext context, index) {
                    return  const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: SubCategoryShimmer(isEnabled: true, hasDivider: false),
                    );
                  },
                );
              }
            })
          ]),
        ),
      ),
    );
  }
}

class SubCategoryShimmer extends StatelessWidget {
  final bool? isEnabled;
  final bool? hasDivider;
  const SubCategoryShimmer({super.key, required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
          : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Get.isDarkMode?Colors.grey[700]:Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: Get.isDarkMode? null: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: desktop ? 70 : 50,
                  width: desktop ? 70 : 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault,),
                Expanded(
                  flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      height: desktop ? 20 : 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Container(
                      height: desktop ? 12 : 8,
                      margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Container(
                      height: desktop ? 12 : 8,
                      margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
