///conversation user for channel model and for conversation model
class ConversationUserModel {
  String? id;
  String? channelId;
  String? userId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? isRead;
  ConversationUser? user;

  ConversationUserModel(
      {this.id,
        this.channelId,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.isRead
      });

  ConversationUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channel_id'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? ConversationUser.fromJson(json['user']) : null;
    isRead= json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channel_id'] = channelId;
    data['user_id'] = userId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ConversationUser {
  String? id;
  String? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  String? dateOfBirth;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  String? phoneVerifiedAt;
  String? emailVerifiedAt;
  int? isActive;
  String? userType;
  String? rememberToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  ProviderModel ? provider;

  ConversationUser(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.dateOfBirth,
        this.gender,
        this.profileImage,
        this.fcmToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.phoneVerifiedAt,
        this.emailVerifiedAt,
        this.isActive,
        this.userType,
        this.rememberToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.provider,
      });

  ConversationUser.fromJson(Map<String, dynamic> json) {
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
    provider = json['provider'] != null ? ProviderModel.fromJson(json['provider']) : null;
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




class ProviderModel {
  String? id;
  String? userId;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  String? companyEmail;
  String? logo;
  String? contactPersonName;
  String? contactPersonPhone;
  String? contactPersonEmail;
  int? orderCount;
  int? serviceManCount;
  int? serviceCapacityPerDay;
  int? ratingCount;
  int? commissionStatus;
  int? commissionPercentage;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isApproved;
  String? zoneId;

  ProviderModel(
      {String? id,
        String? userId,
        String? companyName,
        String? companyPhone,
        String? companyAddress,
        String? companyEmail,
        String? logo,
        String? contactPersonName,
        String? contactPersonPhone,
        String? contactPersonEmail,
        int? orderCount,
        int? serviceManCount,
        int? serviceCapacityPerDay,
        int? ratingCount,
        int? avgRating,
        int? commissionStatus,
        int? commissionPercentage,
        int? isActive,
        String? createdAt,
        String? updatedAt,
        int? isApproved,
        String? zoneId}) {
    if (id != null) {
      id = id;
    }
    if (userId != null) {
      userId = userId;
    }
    if (companyName != null) {
      companyName = companyName;
    }
    if (companyPhone != null) {
      companyPhone = companyPhone;
    }
    if (companyAddress != null) {
      companyAddress = companyAddress;
    }
    if (companyEmail != null) {
      companyEmail = companyEmail;
    }
    if (logo != null) {
      logo = logo;
    }
    if (contactPersonName != null) {
      contactPersonName = contactPersonName;
    }
    if (contactPersonPhone != null) {
      contactPersonPhone = contactPersonPhone;
    }
    if (contactPersonEmail != null) {
      contactPersonEmail = contactPersonEmail;
    }
    if (orderCount != null) {
      orderCount = orderCount;
    }
    if (serviceManCount != null) {
      serviceManCount = serviceManCount;
    }
    if (serviceCapacityPerDay != null) {
      serviceCapacityPerDay = serviceCapacityPerDay;
    }
    if (ratingCount != null) {
      ratingCount = ratingCount;
    }
    if (commissionStatus != null) {
      commissionStatus = commissionStatus;
    }
    if (commissionPercentage != null) {
      commissionPercentage = commissionPercentage;
    }
    if (isActive != null) {
      isActive = isActive;
    }
    if (createdAt != null) {
      createdAt = createdAt;
    }
    if (updatedAt != null) {
      updatedAt = updatedAt;
    }
    if (isApproved != null) {
      isApproved = isApproved;
    }
    if (zoneId != null) {
      zoneId = zoneId;
    }
  }

  ProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyPhone = json['company_phone'];
    companyAddress = json['company_address'];
    companyEmail = json['company_email'];
    logo = json['logo'];
    contactPersonName = json['contact_person_name'];
    contactPersonPhone = json['contact_person_phone'];
    contactPersonEmail = json['contact_person_email'];
    orderCount = json['order_count'];
    serviceManCount = json['service_man_count'];
    serviceCapacityPerDay = json['service_capacity_per_day'];
    ratingCount = json['rating_count'];
    commissionStatus = json['commission_status'];
    commissionPercentage = json['commission_percentage'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = json['is_approved'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['company_phone'] = companyPhone;
    data['company_address'] = companyAddress;
    data['company_email'] = companyEmail;
    data['logo'] = logo;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_phone'] = contactPersonPhone;
    data['contact_person_email'] = contactPersonEmail;
    data['order_count'] = orderCount;
    data['service_man_count'] = serviceManCount;
    data['service_capacity_per_day'] = serviceCapacityPerDay;
    data['rating_count'] = ratingCount;
    data['commission_status'] =commissionStatus;
    data['commission_percentage'] = commissionPercentage;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_approved'] = isApproved;
    data['zone_id'] = zoneId;
    return data;
  }
}