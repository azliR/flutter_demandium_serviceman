import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color color;
  const MainAppBar({
    Key? key,
    this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<NotificationController>(builder: (notificationController){
      return AppBar(
        elevation: 5,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
          child: Image.asset(Images.logo),
        ),
        title: title!=null?
        Text(title!.tr,
          style: ubuntuBold.copyWith(
            color: Theme.of(context).primaryColorLight,
            fontSize: 17,
          ),
        ):Image.asset(Get.isDarkMode?Images.appbarDarkText:Images.appbarText,width: 110,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(const NotificationScreen());
                      notificationController.resetNotificationCount();
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: Theme.of(context).primaryColor,
                    )
                ),
                Positioned(
                  right: 2,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor
                    ),
                    child: FittedBox(
                        child: Text(
                          notificationController.unseenNotificationCount.toString(),
                          style: ubuntuRegular.copyWith(color: light.cardColor
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}
