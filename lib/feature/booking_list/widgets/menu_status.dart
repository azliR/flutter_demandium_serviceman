import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class BookingMenuItem extends GetView<BookingListController> {
  final String title;
  final int index;
  const BookingMenuItem( {Key? key, required this.title, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
          color: controller.bookingStatusState.name.toLowerCase().tr != title ?
          Colors.grey.withOpacity(0.2): Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        children: [
          SizedBox(
            height: 16,
            width: 16,
            child: Image.asset(
              index == 0 ? Images.approvedIcon : index == 1?
              Images.ongoingIcon: Images.languageIcon
            )
          ),
          const SizedBox(width: 5,),
          Text(
            title,
            textAlign: TextAlign.center,
            style:ubuntuMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: controller.bookingStatusState!=BooingListStatus.values.elementAt(index)? Theme.of(context).textTheme.bodyLarge!.color: light.cardColor
            ),
          )
        ],
      ),
    );
  }
}