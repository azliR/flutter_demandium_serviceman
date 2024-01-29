import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  final bool requiredMark;
  final double? fontSize;
  const TextFieldTitle({Key? key, required this.title, this.requiredMark = false, this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeDefault),
      child: RichText(
          text:
            TextSpan(children: <TextSpan>[
                TextSpan(text: title, style: ubuntuRegular.copyWith(color: Theme.of(Get.context!).textTheme.bodyLarge!.color!.withOpacity(0.9), fontSize: fontSize)),
                TextSpan(text: requiredMark?' *':"", style: ubuntuRegular.copyWith(color: Colors.red)),
          ])),
    );
  }
}
