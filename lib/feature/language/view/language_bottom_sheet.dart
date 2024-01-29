import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';



class ChooseLanguageBottomSheet extends StatelessWidget {
  const ChooseLanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    Get.find<LocalizationController>().loadCurrentLanguage(shouldUpdate: false);

    final List<MenuModel> menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.profile, title: 'help_&_support'.tr, route: RouteHelper.getProfileRoute()),
    ];

    menuList.add(MenuModel(icon: Images.logout, title: isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return PointerInterceptor(
      child: GetBuilder<LocalizationController>(
        builder: (localizationController){
          return Container(
            width: Dimensions.webMaxWidth,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Theme.of(context).cardColor,
            ),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Container(
                      height: 5, width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        color: Theme.of(context).hintColor.withOpacity(0.15)
                      ),
                    ),
                    const SizedBox(height:Dimensions.paddingSizeExtraLarge),
                    Text("select_language".tr,style: ubuntuMedium.copyWith( color: Theme.of(context).primaryColorLight, fontSize: Dimensions.fontSizeDefault)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("choose_your_language_to_proceed".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: Get.height * 0.5,
                        minHeight: Get.height * 0.1,
                      ),
                      child: ListView.builder(
                          itemCount: localizationController.languages.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) => InkWell (
                            onTap: () {
                              localizationController.setSelectIndex(index);
                            },
                            child: Container (
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                                  border: Border.all(color: localizationController.selectedIndex == index ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent ),
                                  color:  localizationController.selectedIndex == index ? Get.isDarkMode? Colors.grey.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0.03) : Colors.transparent
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(localizationController.languages[index].imageUrl!, width: 36, height: 36),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),

                                  Text(localizationController.languages[index].languageName!, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                ],
                              ),

                            ),
                          )
                      ),
                    ),

                    GetBuilder<LocalizationController>(builder: (localizationController){
                      return  CustomButton(
                        btnTxt: 'select'.tr,
                        margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        onPressed: () {
                          Get.find<SplashController>().disableIntro();
                          if(localizationController.languages.isNotEmpty && localizationController.selectedIndex != -1) {
                            localizationController.setLanguage(Locale(
                              AppConstants.languages[localizationController.selectedIndex].languageCode!,
                              AppConstants.languages[localizationController.selectedIndex].countryCode,
                            ));
                            Get.back();
                          }else {
                            showCustomSnackBar('select_a_language'.tr);
                          }
                        },
                      );
                    })
                  ],
                ),


                SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
              ]),
            ),
          );
        },
      ),
    );
  }
}
