
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class GeneralInfo extends StatelessWidget {
  const GeneralInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GetBuilder<ProfileController>(
          builder: (controller){
            return controller.contents==null? const ProfileInfoShimmer()
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Stack(alignment: AlignmentDirectional.center,
                      children: [
                        controller.pickedFile==null?
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(''
                              "${Get.find<SplashController>().configModel.content!.imageBaseUrl!}"
                              "${AppConstants.servicemanProfileImagePath}"
                              "${controller.userInfo.profileImage}"
                          ),
                        )

                            :CircleAvatar(radius: 50, backgroundImage:FileImage(File(controller.pickedFile!.path))),

                        IconButton( onPressed: ()=>controller.pickImage(),
                          icon: Icon(Icons.camera_enhance_rounded, color: light.cardColor),
                        ),
                      ],
                    ),
                  ],
                ),

                customRichText("full_name".tr,true,context),
                NonEditableTextField(text: controller.userInfo.firstName??"",text2: controller.userInfo.lastName??""),

                customRichText("email".tr,true,context),
                CustomTextFormField(
                  isShowSuffixIcon: true,
                  controller: controller.emailController,
                  hintText: "enter_email_address".tr,
                  isShowBorder: true,
                ),
                customRichText("select_identity_type".tr,true,context),
                NonEditableTextField(text: controller.userInfo.identificationType!=null?controller.userInfo.identificationType.toString().tr:'',),

                customRichText("identity_number".tr,true,context),
                NonEditableTextField(text: controller.userInfo.identificationNumber??"",),

                const SizedBox(height: Dimensions.paddingSizeLarge),

                if(controller.userInfo.identificationImage!=null && controller.userInfo.identificationImage!.isNotEmpty)
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
                        crossAxisSpacing: Dimensions.paddingSizeSmall,
                        mainAxisSpacing: Dimensions.paddingSizeSmall,
                        mainAxisExtent: 200
                    ),
                    itemBuilder: (context,index){
                      return  InkWell(
                        onTap: ()=> Get.dialog(
                            ImageDialog(imageUrl: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                '${AppConstants.servicemanIdentityImagePath}'
                                '${controller.userInfo.identificationImage![index]}'
                            )
                        ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                          child: CustomImage(
                            fit: BoxFit.fill,
                            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                '${AppConstants.servicemanIdentityImagePath}'
                                '${controller.userInfo.identificationImage![index]}',
                          ),
                        ),
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.userInfo.identificationImage!.length,
                  ),

                const SizedBox(height: Dimensions.paddingSizeLarge),


                controller.isLoading ?
                Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor))

                    : CustomButton(
                    btnTxt: "save".tr,
                    onPressed: ()=> _updateProfile(context,controller)

                ),

                // Padding(
                //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                //   child: Text(
                //     'you_can_only_change_password'.tr,
                //     textAlign: TextAlign.justify,
                //     style: ubuntuRegular.copyWith(
                //       fontSize: Dimensions.fontSizeSmall,
                //       color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)
                //     ),
                //   ),
                // ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
            ]);
          },
        )
      ),
    );
  }

  _updateProfile(BuildContext context, ProfileController profileController) {
    if(profileController.emailController!.text.isEmpty){
      showCustomSnackBar("enter_email_address".tr);
    }
    else{
      profileController.updateProfile();
    }
  }

  Widget customRichText(String title,bool isRequired,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: title,
            style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8))),
        TextSpan(text: isRequired?' *':"", style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error)),
      ])),
    );
  }

}
