import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    double ratio = ResponsiveHelper.isDesktop(context) ? 1.1 : ResponsiveHelper.isTab(context) ? 1.1 : 1.2;

      String aboutUs = Get.find<SplashController>().configModel.content!.aboutUs!;
      String privacyPolicy = Get.find<SplashController>().configModel.content!.privacyPolicy!;
      String termsAndCondition = Get.find<SplashController>().configModel.content!.termsAndConditions!;
      String refundPolicy = Get.find<SplashController>().configModel.content!.refundPolicy!;
      String cancellationPolicy = Get.find<SplashController>().configModel.content!.cancellationPolicy!;


    final List<MenuModel> menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.languageIcon, title: 'language'.tr, route: RouteHelper.getLanguageRoute('menu')),
      MenuModel(icon: Images.chatImage, title: 'inbox'.tr, route: RouteHelper.getInboxScreenRoute()),
      if(aboutUs!='')MenuModel(icon: Images.aboutUs, title: 'about_us'.tr, route: RouteHelper.getHtmlRoute('about_us')),
      if(privacyPolicy!='')MenuModel(icon: Images.privacyPolicy, title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute("privacy-policy")),
      if(termsAndCondition!='') MenuModel(icon: Images.termsConditions, title: 'terms_conditions'.tr, route: RouteHelper.getHtmlRoute('terms-and-condition')),
      if(refundPolicy!='')MenuModel(icon: Images.refundPolicy, title: 'refund_policy'.tr, route: RouteHelper.getHtmlRoute('refund_policy')),
      if(cancellationPolicy!='')MenuModel(icon: Images.cancellationPolicy, title: 'cancellation_policy'.tr, route: RouteHelper.getHtmlRoute('cancellation_policy')),
      MenuModel(icon: Images.logout, title: isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: RouteHelper.signIn),
    ];

    return PointerInterceptor(
      child: Container(
        width: Dimensions.webMaxWidth,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
              childAspectRatio: (1/ratio),
              crossAxisSpacing: Dimensions.paddingSizeExtraSmall, mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
            ),
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              return MenuButton(menu: menuList[index], isLogout: index == menuList.length-1);
            },
          ),
          SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
          SafeArea(
            child: RichText(
              text: TextSpan(
                  text: "app_version".tr,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${AppConstants.appVersion} ",
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                    )
                  ]
              ),
            ),
          ),
          const SizedBox(height: 10)

        ]),
      ),
    );
  }
}
