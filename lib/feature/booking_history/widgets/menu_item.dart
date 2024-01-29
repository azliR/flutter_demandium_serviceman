import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class CategoryTabItem extends GetView<BookingHistoryController> {
  const CategoryTabItem({Key? key, required this.title,this.index}) : super(key: key);
  final String title;
  final int? index;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
          color: controller.currentIndex !=index && Get.isDarkMode?
          Colors.grey.withOpacity(0.2):controller.currentIndex ==index? Theme.of(context).primaryColor:
          Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        children: [
          SizedBox(
            height: 16,
            width: 16,
            child: Image.asset(
              index == 0 ? Images.allIcon :index == 1 ?
              Images.completedIcon:Images.canceledIcon
            )
          ),
          const SizedBox(width: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style:ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,color: controller.currentIndex ==index?
            Colors.white: Theme.of(context).textTheme.bodyLarge!.color),
          )
        ],
      ),
    );
  }
}