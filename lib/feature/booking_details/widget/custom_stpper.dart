import 'package:demandium_serviceman/core/core_export.dart';

class CustomStepper extends StatelessWidget {
  final bool isActive;
  final bool haveLeftBar;
  final bool haveRightBar;
  final String title;
  final bool rightActive;
  final String? icon;
  const CustomStepper({Key? key, required this.title, required this.isActive, required this.haveLeftBar, required this.haveRightBar,
    required this.rightActive, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isActive ? Theme.of(context).primaryColor : Theme.of(context).disabledColor;
    Color right = rightActive ? Theme.of(context).primaryColor : Theme.of(context).disabledColor;

    return Expanded(
      child: Column(children: [

        Column(
          children: [
            Row(children: [
              Expanded(child: haveLeftBar ? Divider(color: color, thickness: 2) : const SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(vertical: isActive ? 5 : 5),
                child: SizedBox(width: 20,child: Image.asset(icon!)),
              ),
              Expanded(child: haveRightBar ? Divider(color: right, thickness: 2) : const SizedBox()),
            ]),
            Text(title,style: isActive? ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: color):ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: color),)
          ],
        ),
      ]),
    );
  }
}
