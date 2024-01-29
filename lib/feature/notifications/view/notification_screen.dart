import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<NotificationController>().getNotifications(1,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: "notifications".tr),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<NotificationController>().getNotifications(1);
          },
        child: GetBuilder<NotificationController>(

          builder: (controller) {

          return controller.isLoading? const NotificationShimmer(): controller.dateList.isEmpty ?
          NoDataScreen(text: 'empty_notifications'.tr,):
          CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(child: Column(children: [
                ListView.builder(
                  itemBuilder: (context, index0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                              vertical: Dimensions.paddingSizeDefault
                          ),
                          width: Get.width,
                          color:Theme.of(context).colorScheme.background,
                          child: Text(Get.find<NotificationController>().dateList[index0],
                            textDirection: TextDirection.ltr,
                            style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7)
                            )
                          )
                        ),
                        ListView.builder(
                          itemBuilder: (context, index1) {
                            return InkWell(
                              onTap:(){
                                showDialog(context: context, builder: (ctx)  => NotificationDialog(
                                  title: controller.notificationList[index0][index1].title.toString().trim(),
                                  subTitle: "${controller.notificationList[index0][index1].description}",
                                  imageUrl:'${Get.find<SplashController>().configModel.content!.imageBaseUrl}''/push-notification/'
                                      '${controller.notificationList[index0][index1].coverImage}',
                                ));
                              },

                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall,
                                    vertical: Dimensions.paddingSizeSmall,

                                  ),
                                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: CustomImage(
                                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                  '/push-notification/''${controller.notificationList[index0][index1].coverImage}',
                                              height: 30, width: 30,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: Dimensions.paddingSizeDefault,),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(controller.notificationList[index0][index1].title.toString().trim(),
                                                  style: ubuntuMedium.copyWith(
                                                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                                                    fontSize: Dimensions.fontSizeDefault
                                                  )
                                                ),
                                                const SizedBox(height: Dimensions.paddingSizeSmall),

                                                Text("${controller.notificationList[index0][index1].description}",
                                                  style: ubuntuRegular.copyWith(
                                                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                                                    fontSize: Dimensions.fontSizeDefault
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ]),
                                          ),

                                          SizedBox(
                                            height: 40, width: 60,
                                            child: Text(DateConverter.convertStringTimeToDate(DateConverter.isoUtcStringToLocalDate(
                                                controller.notificationList[index0][index1].createdAt))
                                            )
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.notificationList[index0].length,
                        )
                      ],
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.dateList.length,
                ),
                controller.isLoading? const CircularProgressIndicator():const SizedBox(),


              ],),
              ),
              const SliverToBoxAdapter(
                child:   SizedBox(height: Dimensions.paddingSizeExtraLarge),
              )
            ]);
        },
      )));
  }
}




