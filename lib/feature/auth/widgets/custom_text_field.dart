import 'package:country_code_picker/country_code_picker.dart';
import 'package:demandium_serviceman/components/code_picker_widget.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';



class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final Function(String)? onSubmit;
  final bool? isEnabled;
  final int? maxLines;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final Function(CountryCode countryCode)? onCountryChanged;

  const CustomTextField(
      {super.key, this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.countryDialCode,
        this.onCountryChanged,
        this.onChanged, this.title = '',
      });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: ubuntuRegular.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        hintText: widget.hintText,
        hintStyle: ubuntuRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(0.5),fontSize: Dimensions.fontSizeDefault),
        prefixIcon: widget.countryDialCode == null ? SizedBox(width: 120, child: Align(
          alignment: Get.find<LocalizationController>().isLtr?Alignment.centerLeft:Alignment.centerRight,
          child: Text(widget.title!, style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeDefault),),
        )) : Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CodePickerWidget(
              onChanged: widget.onCountryChanged,
              initialSelection: widget.countryDialCode,
              favorite: [widget.countryDialCode!],
              showDropDownButton: true,
              showFlagMain: true,
              dialogBackgroundColor: Theme.of(context).cardColor,
              barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
              textStyle: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            )),
        suffixIcon: widget.isPassword! ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).primaryColor),
          onPressed: _toggle,
        ) : null,
      ),
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}