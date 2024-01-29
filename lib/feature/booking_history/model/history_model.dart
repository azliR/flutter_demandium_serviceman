// To parse this JSON data, do
//
//     final bookingItemModel = bookingItemModelFromJson(jsonString);

import 'dart:convert';

BookingItemModel bookingItemModelFromJson(String str) => BookingItemModel.fromJson(json.decode(str));

String bookingItemModelToJson(BookingItemModel data) => json.encode(data.toJson());

class BookingItemModel {
  BookingItemModel({
    this.id,
    this.readableId,
    this.customerId,
    this.providerId,
    this.zoneId,
    this.bookingStatus,
    this.isPaid,
    this.paymentMethod,
    this.transactionId,
    this.totalOrderAmount,
    this.totalTaxAmount,
    this.totalDiscountAmount,
    this.serviceSchedule,
    this.serviceAddressId,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.subCategoryId,
    this.servicemanId,
    this.customer,
    this.scheduleHistories,
  });

  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  String? totalOrderAmount;
  String? totalTaxAmount;
  String? totalDiscountAmount;
  DateTime? serviceSchedule;
  String? serviceAddressId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  CustomerModel? customer;
  List<ScheduleHistory>? scheduleHistories;

  factory BookingItemModel.fromJson(Map<String, dynamic> json) => BookingItemModel(
    id: json["id"],
    readableId: json["readable_id"],
    customerId: json["customer_id"],
    providerId: json["provider_id"],
    zoneId: json["zone_id"],
    bookingStatus: json["booking_status"],
    isPaid: json["is_paid"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    totalOrderAmount: json["total_order_amount"],
    totalTaxAmount: json["total_tax_amount"],
    totalDiscountAmount: json["total_discount_amount"],
    serviceSchedule: DateTime.parse(json["service_schedule"]),
    serviceAddressId: json["service_address_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    servicemanId: json["serviceman_id"],
    customer: CustomerModel.fromJson(json["customer"]),
    //scheduleHistories: List<ScheduleHistory>.from(json["schedule_histories"].map((x) => ScheduleHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "readable_id": readableId,
    "customer_id": customerId,
    "provider_id": providerId,
    "zone_id": zoneId,
    "booking_status": bookingStatus,
    "is_paid": isPaid,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "total_order_amount": totalOrderAmount,
    "total_tax_amount": totalTaxAmount,
    "total_discount_amount": totalDiscountAmount,
    "service_schedule": serviceSchedule!.toIso8601String(),
    "service_address_id": serviceAddressId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "serviceman_id": servicemanId,
    "customer": customer!.toJson(),
    "schedule_histories": List<dynamic>.from(scheduleHistories!.map((x) => x.toJson())),
  };
}

class CustomerModel {
  CustomerModel({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.identificationNumber,
    this.identificationType,
    this.identificationImage,
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
    this.updatedAt, required String address, required String name,
  });

  String? id;
  dynamic roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic identificationNumber;
  String? identificationType;
  List<dynamic> ? identificationImage;
  dynamic dateOfBirth;
  String? gender;
  String? profileImage;
  dynamic fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  dynamic phoneVerifiedAt;
  dynamic emailVerifiedAt;
  int? isActive;
  String? userType;
  dynamic rememberToken;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: json["id"],
    roleId: json["role_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    identificationNumber: json["identification_number"],
    identificationType: json["identification_type"],
    identificationImage: List<dynamic>.from(json["identification_image"].map((x) => x)),
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    profileImage: json["profile_image"],
    fcmToken: json["fcm_token"],
    isPhoneVerified: json["is_phone_verified"],
    isEmailVerified: json["is_email_verified"],
    phoneVerifiedAt: json["phone_verified_at"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"],
    userType: json["user_type"],
    rememberToken: json["remember_token"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    address: json['address'],
    name: json['name'],
  );



  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "identification_number": identificationNumber,
    "identification_type": identificationType,
    "identification_image": List<dynamic>.from(identificationImage!.map((x) => x)),
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "profile_image": profileImage,
    "fcm_token": fcmToken,
    "is_phone_verified": isPhoneVerified,
    "is_email_verified": isEmailVerified,
    "phone_verified_at": phoneVerifiedAt,
    "email_verified_at": emailVerifiedAt,
    "is_active": isActive,
    "user_type": userType,
    "remember_token": rememberToken,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class ScheduleHistory {
  ScheduleHistory({
    this.id,
    this.bookingId,
    this.changedBy,
    this.schedule,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? bookingId;
  String? changedBy;
  DateTime? schedule;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ScheduleHistory.fromJson(Map<String, dynamic> json) => ScheduleHistory(
    id: json["id"],
    bookingId: json["booking_id"],
    changedBy: json["changed_by"],
    schedule: DateTime.parse(json["schedule"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "changed_by": changedBy,
    "schedule": schedule!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
