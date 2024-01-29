class BookingItemModel {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  num? _totalBookingAmount;
  num? totalTaxAmount;
  num? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  Customer? customer;

  BookingItemModel(
      {String? id,
        int? readableId,
        String? customerId,
        String? providerId,
        String? zoneId,
        String? bookingStatus,
        int? isPaid,
        String? paymentMethod,
        String? transactionId,
        num? totalBookingAmount,
        num? totalTaxAmount,
        num? totalDiscountAmount,
        String? serviceSchedule,
        String? serviceAddressId,
        String? createdAt,
        String? updatedAt,
        String? categoryId,
        String? subCategoryId,
        String? servicemanId,
        Customer? customer}) {
    if (id != null) {
      id = id;
    }
    if (readableId != null) {
      readableId = readableId;
    }
    if (customerId != null) {
      customerId = customerId;
    }
    if (providerId != null) {
      providerId = providerId;
    }
    if (zoneId != null) {
      zoneId = zoneId;
    }
    if (bookingStatus != null) {
      bookingStatus = bookingStatus;
    }
    if (isPaid != null) {
      isPaid = isPaid;
    }
    if (paymentMethod != null) {
      paymentMethod = paymentMethod;
    }
    if (transactionId != null) {
      transactionId = transactionId;
    }
    if (totalBookingAmount != null) {
      totalBookingAmount = totalBookingAmount;
    }
    if (totalTaxAmount != null) {
      totalTaxAmount = totalTaxAmount;
    }
    if (totalDiscountAmount != null) {
      totalDiscountAmount = totalDiscountAmount;
    }
    if (serviceSchedule != null) {
      serviceSchedule = serviceSchedule;
    }
    if (serviceAddressId != null) {
      serviceAddressId = serviceAddressId;
    }
    if (createdAt != null) {
      createdAt = createdAt;
    }
    if (updatedAt != null) {
      updatedAt = updatedAt;
    }
    if (categoryId != null) {
      categoryId = categoryId;
    }
    if (subCategoryId != null) {
      subCategoryId = subCategoryId;
    }
    if (servicemanId != null) {
      servicemanId = servicemanId;
    }
    if (customer != null) {
      customer = customer;
    }
  }
  num? get totalBookingAmount => _totalBookingAmount;

  BookingItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    if(json['total_booking_amount'] != null){
      _totalBookingAmount = json['total_booking_amount'];
    }else{
      _totalBookingAmount = 0.0;
    }

    totalTaxAmount = json['total_tax_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    servicemanId = json['serviceman_id'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    data['is_paid'] = isPaid;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['total_booking_amount'] = totalBookingAmount;
    data['total_tax_amount'] = totalTaxAmount;
    data['total_discount_amount'] = totalDiscountAmount;
    data['service_schedule'] = serviceSchedule;
    data['service_address_id'] = serviceAddressId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['serviceman_id'] = servicemanId;
    if (customer != null) {
      data['customer'] =customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? _roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? _identificationNumber;
  String? identificationType;
  List<void>? identificationImage;
  String? _dateOfBirth;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  String? _phoneVerifiedAt;
  String? _emailVerifiedAt;
  int? isActive;
  String? userType;
  String? _rememberToken;
  String? _deletedAt;
  String? createdAt;
  String? updatedAt;

  Customer(
      {String? id,
        String? roleId,
        String? firstName,
        String? lastName,
        String? email,
        String? phone,
        String? identificationNumber,
        String? identificationType,
        List<void>? identificationImage,
        String? dateOfBirth,
        String? gender,
        String? profileImage,
        String? fcmToken,
        int? isPhoneVerified,
        int? isEmailVerified,
        String? phoneVerifiedAt,
        String? emailVerifiedAt,
        int? isActive,
        String? userType,
        String? rememberToken,
        String? deletedAt,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      id = id;
    }
    if (roleId != null) {
      roleId = roleId;
    }
    if (firstName != null) {
      firstName = firstName;
    }
    if (lastName != null) {
      lastName = lastName;
    }
    if (email != null) {
      email = email;
    }
    if (phone != null) {
      phone = phone;
    }

    if (identificationType != null) {
      identificationType = identificationType;
    }
    if (identificationImage != null) {
      identificationImage = identificationImage;
    }
    if (dateOfBirth != null) {
      dateOfBirth = dateOfBirth;
    }
    if (gender != null) {
      gender = gender;
    }
    if (profileImage != null) {
      profileImage = profileImage;
    }
    if (fcmToken != null) {
      fcmToken = fcmToken;
    }
    if (isPhoneVerified != null) {
      isPhoneVerified = isPhoneVerified;
    }
    if (isEmailVerified != null) {
      isEmailVerified = isEmailVerified;
    }
    if (phoneVerifiedAt != null) {
      phoneVerifiedAt = phoneVerifiedAt;
    }
    if (emailVerifiedAt != null) {
      emailVerifiedAt = emailVerifiedAt;
    }
    if (isActive != null) {
      isActive = isActive;
    }
    if (userType != null) {
      userType = userType;
    }
    if (rememberToken != null) {
      rememberToken = rememberToken;
    }
    if (deletedAt != null) {
      deletedAt = deletedAt;
    }
    if (createdAt != null) {
      createdAt = createdAt;
    }
    if (updatedAt != null) {
      updatedAt = updatedAt;
    }
  }
   get roleId => _roleId;
  set roleId(var roleId) => _roleId = roleId;
   get identificationNumber => _identificationNumber;
  set identificationNumber(var identificationNumber) =>
      _identificationNumber = identificationNumber;
   get dateOfBirth => _dateOfBirth;
  set dateOfBirth(var dateOfBirth) => _dateOfBirth = dateOfBirth;
   get phoneVerifiedAt => _phoneVerifiedAt;
  set phoneVerifiedAt(var phoneVerifiedAt) =>
      _phoneVerifiedAt = phoneVerifiedAt;
   get emailVerifiedAt => _emailVerifiedAt;
  set emailVerifiedAt(var emailVerifiedAt) =>
      _emailVerifiedAt = emailVerifiedAt;
   get rememberToken => _rememberToken;
  set rememberToken(var rememberToken) => _rememberToken = rememberToken;
   get deletedAt => _deletedAt;
  set deletedAt(var deletedAt) => _deletedAt = deletedAt;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];

    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    fcmToken = json['fcm_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    emailVerifiedAt = json['email_verified_at'];
    isActive = json['is_active'];
    userType = json['user_type'];
    rememberToken = json['remember_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['identification_number'] = identificationNumber;
    data['identification_type'] = identificationType;

    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['fcm_token'] = fcmToken;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_active'] = isActive;
    data['user_type'] = userType;
    data['remember_token'] = rememberToken;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
