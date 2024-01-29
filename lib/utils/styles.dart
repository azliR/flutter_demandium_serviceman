import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

const ubuntuLight = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w300,
);

const ubuntuRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
);

TextStyle ubuntuRegularLow = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSmall,
);

TextStyle ubuntuRegularMid = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

const ubuntuMedium = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
);

TextStyle ubuntuMediumLow = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeSmall,
);

TextStyle ubuntuMediumMid = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

TextStyle ubuntuMediumHigh = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeLarge,
);



const ubuntuBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w700,
);

TextStyle ubuntuBoldLow = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeSmall
);

TextStyle ubuntuBoldMid = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault
);

TextStyle ubuntuBoldHigh = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeExtraLarge
);

List<BoxShadow>? shadow = Get.isDarkMode? null:[BoxShadow(
  offset: const Offset(0, 1),
  blurRadius: 1,
  color: Colors.black.withOpacity(0.1),
)];

List<BoxShadow>? lightShadow = [BoxShadow(
    offset: const Offset(10,5),
    color: Colors.grey[100]!, blurRadius: 7, spreadRadius: 5)];