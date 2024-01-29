import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class ColumnText extends StatelessWidget {
  final int? amount;
  final String title;
  const ColumnText({Key? key,required this.title,this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .27,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              amount.toString(),
              style: ubuntuBold.copyWith(fontSize: 17),
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            Text(
              title,
              textAlign: TextAlign.center,
              style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
