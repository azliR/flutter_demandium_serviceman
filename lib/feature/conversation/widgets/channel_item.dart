import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class ChannelItem extends StatelessWidget {
  final String channelCreatedTime;
  final ConversationUserModel conversationUserModel;
  final int isRead;
  const ChannelItem({
    Key? key,
    required this.conversationUserModel,
    required this.channelCreatedTime,
    required this.isRead}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imagePath =
    conversationUserModel.user!.userType=="customer"?AppConstants.customerProfileImagePath
        :conversationUserModel.user!.userType=="provider-admin"?AppConstants.providerProfileImagePath
        :conversationUserModel.user!.userType=="provider-serviceman"?AppConstants.servicemanProfileImagePath
        :AppConstants.adminProfileImagePath;

    return InkWell(
      onTap:(){
        String name = conversationUserModel.user!.userType == 'customer' || conversationUserModel.user!.userType == 'super-admin'?
        "${conversationUserModel.user!.firstName!} ${conversationUserModel.user!.lastName!}" : conversationUserModel.user!.provider!.companyName!;

        String phone = conversationUserModel.user!=null? conversationUserModel.user!.phone??"":"";

        String image = conversationUserModel.user!.userType == 'customer' || conversationUserModel.user!.userType == 'super-admin'?
        conversationUserModel.user!.profileImage! : conversationUserModel.user!.provider!.logo!;
        String imageWithPath = "${Get.find<SplashController>().configModel.content!.imageBaseUrl}$imagePath$image";

        String userTypeImage= conversationUserModel.user!.userType == 'customer' ?  'customer' : 'provider';
        Get.find<ConversationController>().setUserImageType(userTypeImage);
        Get.toNamed(RouteHelper.getChatScreenRoute(conversationUserModel.channelId!,name,imageWithPath,phone));
      },

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isRead == 0? Theme.of(context).primaryColor : Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          boxShadow: shadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const SizedBox(width: Dimensions.paddingSizeSmall,),
            //conversationUserModel.user.userType
            ClipRRect(borderRadius: BorderRadius.circular(50),
              child: conversationUserModel.user!=null && conversationUserModel.user!.userType == 'customer' ?
              CustomImage(
                  height: 50, width: 50,
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                      '/user/profile_image/'
                      '${conversationUserModel.user!.profileImage}'
              ):
              conversationUserModel.user!=null && conversationUserModel.user!.userType == 'provider-admin' ?
               CustomImage(
                  height: 50,
                  width: 50,
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                      '/provider/logo/'
                      '${conversationUserModel.user!.provider!.logo}'
              )
              : CustomImage(
                  height: 50,
                  width: 50,
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                      '${AppConstants.adminProfileImagePath}'
                      '${conversationUserModel.user!.profileImage}'
              )
            ),

            Gaps.horizontalGapOf(Dimensions.paddingSizeSmall),

            Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            conversationUserModel.user!.userType == 'customer' || conversationUserModel.user!.userType == 'super-admin'  ?
                            "${conversationUserModel.user!.firstName!} ${conversationUserModel.user!.lastName!}" : conversationUserModel.user!.provider!.companyName!,
                            style: isRead == 0 ?
                            ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: light.cardColor) :
                            ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7), ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),

                    Text(conversationUserModel.user!=null ? conversationUserModel.user!.userType!.tr : "",
                      style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: isRead == 0? light.cardColor : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6) ,
                      ),
                    ),
                  ],
                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(conversationUserModel.user!.userType == "super-admin")
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                          borderRadius: const BorderRadius.all(Radius.circular(12.0))
                      ),
                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: 3),
                        child: Text('support'.tr,style: ubuntuMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: Dimensions.fontSizeSmall),),
                      )),
                if(conversationUserModel.user!.userType == "super-admin")
                  const SizedBox(height: 10,),

                SizedBox(
                  width: Get.width*.25,
                  child: Text(DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(channelCreatedTime)),
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                      color: isRead == 0? light.cardColor : Theme.of(context).hintColor,),
                    maxLines: 2,textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall,),
          ],
        ),
      ),
    );
  }
}

