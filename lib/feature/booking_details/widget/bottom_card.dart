import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class BottomCard extends StatelessWidget {

  const BottomCard({Key? key, required this.name, required this.phone, required this.image, this.address}) : super(key: key);

  final String name;
  final String phone;
  final String image;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          boxShadow: shadow
      ),


      child: Column(
        children: [

          const SizedBox(height: Dimensions.paddingSizeDefault,),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomImage(
              height: 50,
              width: 50,
              image: image,
            )
          ),

          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Text(name, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,),textAlign: TextAlign.center,),

          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Text(phone, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7))),

          const SizedBox(height: Dimensions.paddingSizeSmall,),
          address != null ?
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              text: TextSpan(text: '${'service_address'.tr} :',
                style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              children: [
                  TextSpan(
                    text: ' $address',
                      style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                      ),
                  ),
              ],
            ),
              textAlign: TextAlign.center),
          ) : const SizedBox(),

           const SizedBox(height:Dimensions.paddingSizeSmall),
        ],
      ),
    );
  }
}