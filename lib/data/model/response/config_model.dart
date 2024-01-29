class ConfigModel {
  String? responseCode;
  String? message;
  Content? content;


  ConfigModel({String? responseCode, String? message, Content? content, List<void>? errors}) {
    if (responseCode != null) {
      responseCode = responseCode;
    }
    if (message != null) {
      message = message;
    }
    if (content != null) {
      content = content;
    }

  }

  ConfigModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? Content.fromJson(json['content']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class Content {
  String? _currencySymbolPosition;
  int? _providerSelfRegistration;
  String? _businessName;
  String? _logo;
  String? _countryCode;
  String? _businessAddress;
  String? _businessPhone;
  String? _businessEmail;
  String? _baseUrl;
  String? _currencyCode;
  String? _aboutUs;
  String? _privacyPolicy;
  String? _termsAndConditions;
  String? _refundPolicy;
  String? _returnPolicy;
  String? _cancellationPolicy;
  String? _appUrlAndroid;
  String? _appUrlIos;
  int? _smsVerification;
  int? _phoneVerification;
  String? _imageBaseUrl;
  int? _paginationLimit;
  String? _currencyDecimalPoint;
  MinimumVersion? _minimumVersion;
  String? _footerText;
  int? _sendOtpTimer;
  String? _forgetPasswordVerificationMethod;
  int? _bookingOtpVerification;
  int? _bookingImageVerification;
  String? _additionalChargeLabelName;
  int? _serviceManCanCancelBooking;
  int? _serviceManCanEditBooking;
  int? _providerServicemanCanCancelBooking;
  int? _providerServicemanCanEditBooking;
  String? _currencySymbol;


  Content({String? currencySymbolPosition,
    int? providerSelfRegistration,
    String? businessName,
    String? logo,
    String? countryCode,
    String? businessAddress,
    String? businessPhone,
    String? businessEmail,
    String? baseUrl,
    String? currencyCode,
    String? aboutUs,
    String? privacyPolicy,
    String? termsAndConditions,
    String? refundPolicy,
    String? returnPolicy,
    String? cancellationPolicy,
    String? appUrlAndroid,
    String? appUrlIos,
    int? smsVerification,
    int? phoneVerification,
    String? imageBaseUrl,
    int? paginationLimit,
    String? currencyDecimalPoint,
    MinimumVersion? minimumVersion,
    String? footerText,
    int? sendOtpTimer,
    String? forgetPasswordVerificationMethod,
    int? bookingOtpVerification,
    int? bookingImageVerification,
    String? additionalChargeLabelName,
    int? serviceManCanCancelBooking,
    int? serviceManCanEditBooking,
    int? providerServicemanCanCancelBooking,
    int? providerServicemanCanEditBooking,
    String? currencySymbol,


  }) {
    if (currencySymbolPosition != null) {
      _currencySymbolPosition = currencySymbolPosition;
    }
    if (providerSelfRegistration != null) {
      _providerSelfRegistration = providerSelfRegistration;
    }
    if (businessName != null) {
      _businessName = businessName;
    }
    if (logo != null) {
      _logo = logo;
    }
    if (countryCode == null) {
      _countryCode = countryCode;
    }
    if (businessAddress != null) {
      _businessAddress = businessAddress;
    }
    if (businessPhone != null) {
      _businessPhone = businessPhone;
    }
    if (businessEmail != null) {
      _businessEmail = businessEmail;
    }
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }
    if (currencyCode != null) {
      _currencyCode = currencyCode;
    }
    if (aboutUs != null) {
      _aboutUs = aboutUs;
    }
    if (privacyPolicy != null) {
      _privacyPolicy = privacyPolicy;
    }
    if (termsAndConditions != null) {
      _termsAndConditions = termsAndConditions;
    }
    if (refundPolicy != null) {
      _refundPolicy = refundPolicy;
    }
    if (returnPolicy != null) {
      _returnPolicy = returnPolicy;
    }
    if (cancellationPolicy != null) {
      _cancellationPolicy = cancellationPolicy;
    }

    if (appUrlAndroid != null) {
      _appUrlAndroid = appUrlAndroid;
    }
    if (appUrlIos != null) {
      _appUrlIos = appUrlIos;
    }
    if (smsVerification != null) {
      _smsVerification = smsVerification;
    }
    if (phoneVerification != null) {
      _phoneVerification = phoneVerification;
    }
    if (imageBaseUrl != null) {
      _imageBaseUrl = imageBaseUrl;
    }
    if (paginationLimit != null) {
      _paginationLimit = paginationLimit;
    }
    if (currencyDecimalPoint != null) {
      _currencyDecimalPoint = currencyDecimalPoint;
    }
    if (minimumVersion != null) {
      _minimumVersion = minimumVersion;
    }
    if (footerText != null) {
      _footerText = footerText;
    }
    if (sendOtpTimer != null) {
      _sendOtpTimer = sendOtpTimer;
    }
    if (forgetPasswordVerificationMethod != null) {
      _forgetPasswordVerificationMethod = forgetPasswordVerificationMethod;
    }
    if (bookingOtpVerification != null) {
      _bookingOtpVerification = bookingOtpVerification;
    }
    if (bookingImageVerification != null) {
      _bookingImageVerification = bookingImageVerification;
    }

    if (additionalChargeLabelName!= null) {
      _additionalChargeLabelName = additionalChargeLabelName;
    }

    if (serviceManCanCancelBooking != null) {
      _serviceManCanCancelBooking = serviceManCanCancelBooking;
    }

    if (serviceManCanEditBooking != null) {
      _serviceManCanEditBooking = serviceManCanEditBooking;
    }

    if (providerServicemanCanCancelBooking != null) {
      _providerServicemanCanCancelBooking = providerServicemanCanCancelBooking;
    }

    if (_providerServicemanCanEditBooking != null) {
      _providerServicemanCanEditBooking = providerServicemanCanEditBooking;
    }

    if (_currencySymbol != null) {
      _currencySymbol = currencySymbol;
    }
  }

  String? get currencySymbolPosition => _currencySymbolPosition;

  int? get providerSelfRegistration => _providerSelfRegistration;

  String? get businessName => _businessName;

  String? get logo => _logo;

  String? get countryCode => _countryCode;

  String? get businessAddress => _businessAddress;

  String? get businessPhone => _businessPhone;

  String? get businessEmail => _businessEmail;

  String? get baseUrl => _baseUrl;

  String? get currencyCode => _currencyCode;

  String? get aboutUs => _aboutUs;

  String? get privacyPolicy => _privacyPolicy;

  String? get termsAndConditions => _termsAndConditions;

  String? get refundPolicy => _refundPolicy;

  String? get returnPolicy => _returnPolicy;

  String? get cancellationPolicy => _cancellationPolicy;

  String? get appUrlAndroid => _appUrlAndroid;

  String? get appUrlIos => _appUrlIos;

  int? get smsVerification => _smsVerification;

  int? get phoneVerification => _phoneVerification;


  String? get imageBaseUrl => _imageBaseUrl;

  int? get paginationLimit => _paginationLimit;

  String? get currencyDecimalPoint => _currencyDecimalPoint;

  MinimumVersion? get minimumVersion => _minimumVersion;

  String? get footerText => _footerText;
  int? get sendOtpTimer => _sendOtpTimer;
  String? get forgetPasswordVerificationMethod => _forgetPasswordVerificationMethod;
  int? get bookingOtpVerification => _bookingOtpVerification;
  int? get bookingImageVerification => _bookingImageVerification;
  String ? get additionalChargeLabelName => _additionalChargeLabelName;

  int? get serviceManCanCancelBooking => _serviceManCanCancelBooking;
  int? get serviceManCanEditBooking => _serviceManCanEditBooking ;
  int? get providerServicemanCanCancelBooking => _providerServicemanCanCancelBooking;
  int? get providerServicemanCanEditBooking => _providerServicemanCanEditBooking;
  String? get currencySymbol => _currencySymbol;


  Content.fromJson(Map<String, dynamic> json) {
    _currencySymbolPosition = json['currency_symbol_position'];
    _providerSelfRegistration = json['provider_self_registration'];
    _businessName = json['business_name'];
    _logo = json['logo'];
    _countryCode = json['country_code'];
    _businessAddress = json['business_address'];
    _businessPhone = json['business_phone'];
    _businessEmail = json['business_email'];
    _baseUrl = json['base_url'];
    _currencyCode = json['currency_code'];
    _aboutUs = json['about_us'];
    _privacyPolicy = json['privacy_policy'];
    _termsAndConditions = json['terms_and_conditions'];
    _refundPolicy = json['refund_policy'];
    _returnPolicy = json['return_policy'];
    _cancellationPolicy = json['cancellation_policy'];
    _appUrlAndroid = json['app_url_android'];
    _appUrlIos = json['app_url_ios'];
    _smsVerification = json['sms_verification'];
    _phoneVerification = json['phone_verification'];

    _imageBaseUrl = json['image_base_url'];
    _paginationLimit = json['pagination_limit'];

    _currencyDecimalPoint = json['currency_decimal_point'];
    _minimumVersion = json['min_versions'] != null
        ? MinimumVersion.fromJson(json['min_versions'])
        : null;
    _footerText = json['footer_text'];
    _sendOtpTimer = int.tryParse(json['otp_resend_time'].toString());
    _forgetPasswordVerificationMethod = json['forget_password_verification_method'];
    _bookingOtpVerification = int.tryParse(json['booking_otp_verification'].toString());
    _bookingImageVerification = int.tryParse(json['service_complete_photo_evidence'].toString());
    _additionalChargeLabelName = json['additional_charge_label_name'];
    _serviceManCanCancelBooking = int.tryParse(json['serviceman_can_cancel_booking'].toString());
    _serviceManCanEditBooking = int.tryParse(json['serviceman_can_edit_booking'].toString());
    _providerServicemanCanCancelBooking= int.tryParse(json['provider_serviceman_can_cancel_booking'].toString());
    _providerServicemanCanEditBooking = int.tryParse(json['provider_serviceman_can_edit_booking'].toString());
    _currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_symbol_position'] = _currencySymbolPosition;
    data['provider_self_registration'] = _providerSelfRegistration;
    data['business_name'] = _businessName;
    data['logo'] = _logo;
    data['country_code'] = _countryCode;
    data['business_address'] = _businessAddress;
    data['business_phone'] = _businessPhone;
    data['business_email'] = _businessEmail;
    data['base_url'] = _baseUrl;
    data['currency_code'] = _currencyCode;
    data['about_us'] = _aboutUs;
    data['privacy_policy'] = _privacyPolicy;
    data['terms_and_conditions'] = _termsAndConditions;
    data['refund_policy'] = _refundPolicy;
    data['return_policy'] = _returnPolicy;
    data['cancellation_policy'] = _cancellationPolicy;
    data['app_url_android'] = _appUrlAndroid;
    data['app_url_ios'] = _appUrlIos;
    data['sms_verification'] = _smsVerification;
    data['phone_verification'] = _phoneVerification;
    data['image_base_url'] = _imageBaseUrl;
    data['pagination_limit'] = _paginationLimit;
    data['currency_decimal_point'] = _currencyDecimalPoint;
    if (_minimumVersion != null) {
      data['min_versions'] = _minimumVersion!.toJson();
    }
    data['footer_text'] = _footerText;
    data['otp_resend_time'] = _sendOtpTimer;
    data['forget_password_verification_method'] = _forgetPasswordVerificationMethod;
    data['otpVerification'] = _bookingOtpVerification;
    data['currency_symbol'] = _currencySymbol;
    return data;
  }
}
class MinimumVersion {
  String? minVersionForAndroid;
  String? minVersionForIos;

  MinimumVersion({String? minVersionForAndroid, String? minVersionForIos}) {
    if (minVersionForAndroid != null) {
      minVersionForAndroid = minVersionForAndroid;
    }
    if (minVersionForIos != null) {
      minVersionForIos = minVersionForIos;
    }
  }

  MinimumVersion.fromJson(Map<String, dynamic> json) {
    minVersionForAndroid = json['min_version_for_android'];
    minVersionForIos = json['min_version_for_ios'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_version_for_android'] = minVersionForAndroid;
    data['min_version_for_ios'] = minVersionForIos;
    return data;
  }
}
