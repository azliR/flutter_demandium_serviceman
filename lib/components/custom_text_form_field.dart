import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final Function(String)? onSubmit;
  final Function()? onSaved;
  final String? Function(String?)? onValidate;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final bool? enabled;
  final TextCapitalization? capitalization;

  const CustomTextFormField(
      {Key? key,
        this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.fillColor,
        this.onSubmit,
        this.isCountryPicker = false,
        this.isShowBorder = false,
        this.isShowSuffixIcon = false,
        this.isShowPrefixIcon = false,
        this.isIcon = false,
        this.isPassword = false,
        this.suffixIconUrl,
        this.prefixIconUrl,
        this.onSaved,
        this.onValidate,
        this.capitalization = TextCapitalization.none,
        this.enabled=true,
        this.isSearch = false})
      : super(key: key);

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textCapitalization: widget.capitalization!,
      style: ubuntuRegular.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Get.isDarkMode?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7): Theme.of(context).primaryColor,
      obscureText: widget.isPassword ? _obscureText : false,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
        disabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Get.isDarkMode?Theme.of(context).disabledColor.withOpacity(0.5):Theme.of(context).hintColor.withOpacity(0.5)),
        ),

        errorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          borderSide:  BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          borderSide:  BorderSide(color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          borderSide:  BorderSide(color: Get.isDarkMode?Theme.of(context).disabledColor:Theme.of(context).hintColor),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor.withOpacity(0.1),
        hintStyle: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor.withOpacity(0.5)),
        filled: true,

        prefixIcon: widget.isShowPrefixIcon
            ? Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeLarge,
              right: Dimensions.paddingSizeSmall),
          child: Image.asset(widget.prefixIconUrl!),
        )
            : const SizedBox.shrink(),
        prefixIconConstraints:
        const BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
            ? IconButton(
            icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).hintColor.withOpacity(.3)),
            onPressed: _toggle)
            : widget.isIcon
            ? Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeLarge,
              right: Dimensions.paddingSizeSmall),
          child: Image.asset(
            widget.suffixIconUrl!,
            width: 15,
            height: 15,
          ),
        )
            : null
            : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      /*onSaved: (value) {
        widget.controller != value;
      },*/
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
