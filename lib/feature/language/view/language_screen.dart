import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            GetBuilder<LocalizationController>(
              builder: (localizationController){
                return Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Get.isDarkMode?Images.demandiumDarkLogo: Images.demandiumLogo, width: 180),
                            const SizedBox(height:Dimensions.paddingSizeExtraLarge),
                            const SizedBox(height:Dimensions.paddingSizeExtraLarge),
                            Row(
                              children: [
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                Text("select_language".tr,style: ubuntuMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeDefault),),
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                              ],
                            ),

                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 :
                                ResponsiveHelper.isTab(context) ? 3 : 2,
                                childAspectRatio: (1/1),
                              ),
                              itemCount: localizationController.languages.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                              itemBuilder: (context, index) => LanguageWidget(
                                languageModel: localizationController.languages[index],
                                localizationController: localizationController, index: index,
                              ),
                            ),
                            const SizedBox(height:Dimensions.paddingSizeSmall),

                            Row(
                              children: [
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                Text("language_hint_text".tr,style: ubuntuRegular.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeSmall),),
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            GetBuilder<LocalizationController>(builder: (localizationController){
              return  CustomButton(
                btnTxt: 'save'.tr,
                margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                onPressed: () {
                  Get.find<SplashController>().disableIntro();
                  if(localizationController.languages.isNotEmpty && localizationController.selectedIndex != -1) {
                    localizationController.setLanguage(Locale(
                      AppConstants.languages[localizationController.selectedIndex].languageCode!,
                      AppConstants.languages[localizationController.selectedIndex].countryCode,
                    ), isInitial: true);
                    Get.offNamed(RouteHelper.signIn);
                  }else {
                    showCustomSnackBar('select_a_language'.tr);
                  }
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
