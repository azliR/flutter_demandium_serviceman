import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

enum NoDataType {
  cart,
  notification,
  order,
  conversation,
  others,
}

class NoDataScreen extends StatelessWidget {
  final NoDataType? type;
  final String? text;
  const NoDataScreen({super.key, required this.text, this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(),
            Image.asset(
              (type == NoDataType.cart || type == NoDataType.order)
                  ? Images.emptyNotification
                  : type == NoDataType.conversation
                  ? Images.chatImage
                  : type == NoDataType.notification
                  ? Images.emptyNotification
                  : Images.emptyNotification,
              width: MediaQuery.of(context).size.height * 0.10,
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Text(
              type == NoDataType.cart
                  ? 'cart_is_empty'.tr
                  : type == NoDataType.order
                  ? 'sorry_your_order_history_is_Empty'.tr
                  : type == NoDataType.conversation
                  ? 'your_inbox_list_empty_right_now'.tr
                  : type == NoDataType.notification
                  ? 'empty_notifications'.tr
                  : text!,
              style: ubuntuMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            //Text("There are no Services".tr),
          ]),
    );
  }
}