import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String update = '/update';
  static const String profile = '/profile';
  static const String profileInformation = '/profile-information';
  static const String bankInfo = '/bank-info';
  static const String mySubscription = '/my-subscription';
  static const String html = '/html';
  static const String bookingDetails = '/booking-details';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String notification = '/notification';
  static const String bookingRequest = '/booking-request';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String invoice = '/invoice';
  static String getInitialRoute() => initial;
  static String getSplashRoute(NotificationBody? body) {
    String data = 'null';
    if(body != null) {
      List<int> encoded = utf8.encode(jsonEncode(body));
      data = base64Encode(encoded);
    }
    return '$splash?data=$data';
  }
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getChatScreenRoute(String channelId,String name,String image,String userType,{String? fromNotification}) =>
      '$chatScreen?channelID=$channelId&name=$name&image=$image&userType=$userType&fromNotification=$fromNotification';
  static String getInboxScreenRoute({String? fromNotification}) => '$chatInbox?fromNotification=$fromNotification';
  static String getProfileRoute() => profile;
  static String getBankInfoRoute() => bankInfo;
  static String getMySubscriptionRoute() => mySubscription;
  static String getHtmlRoute(String page) => '$html?page=$page';
  static String getBookingDetailsRoute(String bookingId, String bookingStatus, String fromPage,{String? subcategoryId}) =>
      '$bookingDetails?booking_id=$bookingId&booking_status=$bookingStatus&fromPage=$fromPage&subcategory_id=$subcategoryId';
  static String getBookingReqRoute() => bookingRequest;
  static String getForgotPasswordRoute() => forgotPassword;

  static String getVerificationRoute(String identity,String identityType) {
    String data = Uri.encodeComponent(jsonEncode(identity));
    return '$verification?identity=$data&identity_type=$identityType';
  }

  static String getChangePasswordRoute(String identity,String identityType ,String otp) {
    String identity0 = Uri.encodeComponent(jsonEncode(identity));
    String otp0 = Uri.encodeComponent(jsonEncode(otp));
    return '$changePassword?identity=$identity0&identity_type=$identityType&otp=$otp0';
  }

  static String getInvoiceRoute(String bookingId) => '$invoice?booking_id=$bookingId';
  static String getNotificationRoute() => notification;



  static List<GetPage> routes = [
    GetPage(name: initial, page: () => getRoute(const HomeScreen(pageIndex: 0))),
    GetPage(name: splash,
        page: () {
          NotificationBody? data;
          if(Get.parameters['data'] != 'null') {
            List<int> decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
            data = NotificationBody.fromJson(jsonDecode(utf8.decode(decode)));
          }
          return SplashScreen(body: data);
        },
        binding: SplashBinding()
    ),

    GetPage(name: profile, page: () => const ProfileScreen(),binding: UserBinding()),
    GetPage(name: notification, page: () => const NotificationScreen()),
    GetPage(name: signIn, page: () => const SignInScreen(exitFromApp: false,)),

    GetPage(name: bookingDetails, binding: BookingDetailsBinding(),
        page: () => getRoute(BookingDetails(
          bookingStatus: Get.parameters['booking_status'].toString(),
          bookingId: Get.parameters['booking_id'].toString(),
          fromPage: Get.parameters['fromPage'],
          subcategoryId: Get.parameters['subcategory_id'].toString(),
        ))
    ),

    GetPage(name: profileInformation, page: () => getRoute(const ProfileInformationScreen())),
    GetPage(name: bookingRequest, page: () => getRoute(const BookingListScreen()),binding:  BookingListBinding()),
    GetPage( name: chatScreen, page: () => getRoute(ConversationScreen(
      channelID: Get.parameters['channelID']!,
      name: Get.parameters['name']!,
      userType: Get.parameters['userType']!,
      image: Get.parameters['image']!,
      formNotification: Get.parameters['fromNotification'],
    )
    )),    GetPage(name: forgotPassword, page:() => getRoute(const ForgetPassScreen()),),

    GetPage(name: verification, page:() {
      String data = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));

      return VerificationScreen(
        identity: data,
        identityType: Get.parameters['identity_type']!,
      );
    }),

    GetPage(name: changePassword, page:() {
      String identity0 = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));
      String otp0 = Uri.decodeComponent(jsonDecode(Get.parameters['otp']!));

      return NewPassScreen(
          identity: identity0,
          identityType:  Get.parameters['identity_type']!,
          otp: otp0
      );
    }),
    GetPage(name: language, page: () => const ChooseLanguageBottomSheet()),
    GetPage(name: html, page: () => HtmlViewerScreen(
      htmlType: Get.parameters['page'] == 'terms-and-condition' ? HtmlType.termsAndCondition
      : Get.parameters['page'] == 'privacy-policy' ? HtmlType.privacyPolicy :Get.parameters['page'] == 'refund_policy' ?
      HtmlType.refundPolicy: Get.parameters['page'] == 'return_policy' ? HtmlType.returnPolicy:
      Get.parameters['page'] == 'cancellation_policy' ? HtmlType.cancellationPolicy :
      HtmlType.aboutUs,
    ),binding: HtmlBindings()),
    GetPage(name: chatInbox,binding: ConversationBinding(), page: () =>  ChannelList(
      fromNotification: Get.parameters['fromNotification'],
    )),
    GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
  ];

  static getRoute(Widget navigateTo) {

    return navigateTo;
  }
}