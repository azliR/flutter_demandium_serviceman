import 'package:demandium_serviceman/core/core_export.dart';

class AppConstants {
  static const String appName = 'Hirafi Serviceman';
  static const String appUser = 'Serviceman App';
  static const String appVersion = '2.3';
  static const String baseUrl = 'https://admin.hirafi.net';
  static const String loginUrl = '/api/v1/serviceman/auth/login';
  static const String configUrl = '/api/v1/serviceman/config';
  static const String bookingRequestUrl = '/api/v1/serviceman/booking/list';
  static const String dashboardUrl = '/api/v1/serviceman/dashboard';
  static const String profileInfoUrl = '/api/v1/serviceman/info';
  static const String updatePasswordUrl = '/api/v1/serviceman/profile/change-password';
  static const String updateProfileUrl = '/api/v1/serviceman/update/profile';
  static const String notificationUrl = '/api/v1/serviceman/push-notifications';
  static const String bookingDetailsUrl = '/api/v1/serviceman/booking/detail';
  static const String statusUpdateUrl = '/api/v1/serviceman/booking/status-update';
  static const String bookingOTPNotificationUri = '/api/v1/serviceman/booking/opt/notification-send';
  static const String forgetPasswordUrl = '/api/v1/serviceman/forgot-password';
  static const String otpVerificationUrl = '/api/v1/serviceman/otp-verification';
  static const String resetPasswordUrl = '/api/v1/serviceman/reset-password';
  static const String createChannelUrl = '/api/v1/serviceman/chat/create-channel';
  static const String getChannelList = '/api/v1/serviceman/chat/channel-list';
  static const String getConversation = '/api/v1/serviceman/chat/conversation';
  static const String sendMessage = '/api/v1/serviceman/chat/send-message';
  static const String paymentStatusUpdate = '/api/v1/serviceman/booking/payment-status-update';
  static const String verifyTokenUri = '/api/v1/auth/verify-token';
  static const String tokenUri = '/api/v1/serviceman/update/fcm-token';
  static const String pages = '/api/v1/customer/config/pages';
  static const String serviceListBasedOnSubCategory = '/api/v1/serviceman/service/data/sub-category-wise';
  static const String getBookingPriceList = '/api/v1/serviceman/booking/service/info';
  static const String removeCartServiceFromServer = '/api/v1/serviceman/booking/service/edit/remove-service';
  static const String updateBooking = '/api/v1/serviceman/booking/service/edit/update-booking';


  static const String sendOtpForForgetPassword = '/api/v1/user/forget-password/send-otp';
  static const String verifyOtpForForgetPasswordScreen = '/api/v1/user/forget-password/verify-otp';
  static const String resetPasswordUri = '/api/v1/user/forget-password/reset';
  static const String changeLanguage = '/api/v1/serviceman/change-language';


  // image path
  static const String businessLogoPath = '/business/';
  static const String categoryImagePath = '/category/';
  static const String pushNotificationImagePath = '/push-notification/';
  static const String serviceImagePath = '/service/';

  static const String customerProfileImagePath = '/user/profile_image/';
  static const String providerProfileImagePath = '/provider/logo/';
  static const String providerIdentityImagePath = '/provider/identity/';
  static const String servicemanProfileImagePath = '/serviceman/profile/';
  static const String servicemanIdentityImagePath = '/serviceman/identity/';
  static const String adminProfileImagePath = '/user/profile_image/';


  // Shared Key
  static const String theme = 'demand_theme';
  static const String token = 'demand_token';
  static const String countryCode = 'demand_country_code';
  static const String languageCode = 'demand_language_code';
  static const String cartList = 'demand_cart_list';
  static const String userPassword = 'demand_user_password';
  static const String userAddress = 'demand_user_address';
  static const String userNumber = 'demand_user_number';
  static const String userCountryCode = 'demand_user_country_code';
  static const String notification = 'demand_notification';
  static const String searchHistory = 'demand_search_history';
  static const String notificationCount = 'demand_notification_count';
  static const String topic = 'provider-serviceman';
  static const String zoneId = 'zoneId';
  static const String localizationKey = 'X-localization';
  static const String intro = 'intro';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.usa, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(imageUrl: Images.bn, languageName: 'বাংলা', countryCode: 'BD', languageCode: 'bn'),
    LanguageModel(imageUrl: Images.india, languageName: 'Hindi', countryCode: 'IN', languageCode: 'hi'),
  ];
}
