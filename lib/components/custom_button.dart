import 'package:demandium_serviceman/core/core_export.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final bool? transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final IconData? icon;
  final Color? color;
  final String btnTxt;
  final bool isLoading;
  const CustomButton({super.key, this.onPressed, this.transparent = false, this.margin, this.width, this.height,this.color,
    this.fontSize, this.radius = 5, this.icon,required this.btnTxt, this.isLoading = false });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      elevation: 0,
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent!
          ? Colors.transparent :color ?? Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : Dimensions.webMaxWidth, height != null ? height! : 45),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
    );

    return Center(child: SizedBox(width: width ?? Dimensions.webMaxWidth, child: Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: ElevatedButton(
        onPressed: onPressed,
        style: flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null ? Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall),
            child: Icon(icon, color: transparent! ? Theme.of(context).primaryColor : Theme.of(context).cardColor, size: fontSize ?? Dimensions.fontSizeLarge,),
          ) : const SizedBox(),

          isLoading ? Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: SizedBox(height: fontSize ?? Dimensions.fontSizeDefault , width: fontSize ?? Dimensions.fontSizeDefault,
              child: CircularProgressIndicator(color:  transparent! ? Theme.of(context).primaryColor : Colors.white, strokeWidth: 3,),
            ),
          ): const SizedBox(),

          Text(btnTxt, textAlign: TextAlign.center, style: ubuntuMedium.copyWith(
            color: transparent! ? Theme.of(context).primaryColor : Colors.white,
            fontSize: fontSize ?? Dimensions.fontSizeLarge,
          )),
        ]),
      ),
    )));
  }
}