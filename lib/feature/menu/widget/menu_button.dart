import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class MenuButton extends StatelessWidget {
  final MenuModel? menu;
  final bool? isLogout;
  const MenuButton({super.key, @required this.menu, @required this.isLogout});

  @override
  Widget build(BuildContext context) {
    int count = ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4;
    double size = ((context.width > Dimensions.webMaxWidth ? Dimensions.webMaxWidth : context.width)/count)-Dimensions.paddingSizeDefault;

    return InkWell(
      onTap: () async {
        if(isLogout!) {
          Get.back();
          if(Get.find<AuthController>().isLoggedIn()) {
            Get.dialog(
              ConfirmationDialog(
                icon: Images.logout,
                title: 'are_you_sure_to_logout'.tr,
                onNoPressed: () {
                  Get.back();
                },
                onYesPressed: () {
                  Get.find<AuthController>().clearSharedData();
                  Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }, description: '',),
              useSafeArea: false,
            );
          }else {
          }
        }
        else if(menu!.route!.contains('profile')) {
          Get.offNamed(RouteHelper.getProfileRoute());
        }else if(menu!.route!.contains('language')) {
          Get.back();
          Get.bottomSheet(const ChooseLanguageBottomSheet(), backgroundColor: Colors.transparent, isScrollControlled: true);
        }
        else {
          Get.offNamed(menu!.route!);
        }
      },

      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
            color: Get.isDarkMode?Colors.grey.withOpacity(0.2):Theme.of(context).primaryColor.withOpacity(0.05),
          ),
          height: size-(size*0.2),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          alignment: Alignment.center,
          child: Image.asset(menu!.icon!, width: size, height: size),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(menu!.title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),
      ]),
    );
  }
}

