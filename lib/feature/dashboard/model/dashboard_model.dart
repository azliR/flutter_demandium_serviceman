class DashboardModel {
  String? responseCode;
  String? message;
  List<Content>? content;


  DashboardModel({this.responseCode, this.message, this.content});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Content {
  TopCards? topCards;
  List<StatsMonthly>? bookingStats;
  List<DashboardBooking>? bookings;

  Content({this.topCards, this.bookingStats, this.bookings});

  Content.fromJson(Map<String, dynamic> json) {
    topCards = json['top_cards'] != null
        ? TopCards.fromJson(json['top_cards'])
        : null;
    if (json['booking_stats'] != null) {
      bookingStats = <StatsMonthly>[];
      json['booking_stats'].forEach((v) {
        bookingStats!.add(StatsMonthly.fromJson(v));
      });
    }
    if (json['bookings'] != null) {
      bookings = <DashboardBooking>[];
      json['bookings'].forEach((v) {
        bookings!.add(DashboardBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topCards != null) {
      data['top_cards'] = topCards!.toJson();
    }
    if (bookingStats != null) {
      data['booking_stats'] =
          bookingStats!.map((v) => v.toJson()).toList();
    }
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopCards {
  int? pendingBookings;
  int? ongoingBookings;
  int? completedBookings;
  int? canceledBookings;

  TopCards(
      {this.pendingBookings,
        this.ongoingBookings,
        this.completedBookings,
        this.canceledBookings});

  TopCards.fromJson(Map<String, dynamic> json) {
    pendingBookings = int.parse(json['total_bookings'].toString());
    ongoingBookings = int.parse(json['ongoing_bookings'].toString());
    completedBookings = int.parse(json['completed_bookings'].toString());
    canceledBookings = int.parse(json['canceled_bookings'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pending_bookings'] = pendingBookings;
    data['ongoing_bookings'] = ongoingBookings;
    data['completed_bookings'] = completedBookings;
    data['canceled_bookings'] = canceledBookings;
    return data;
  }
}

///Mothly Stats
class StatsMonthly{
  int? total;
  int? year;
  String? month;
  int? day;

  StatsMonthly({this.total, this.year, this.month, this.day});

  StatsMonthly.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}

class DashboardBooking {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  num? totalBookingAmount;
  num? totalTaxAmount;
  num? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  List<RecentOrderDetail>? detail;

  DashboardBooking(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.isPaid,
        this.paymentMethod,
        this.transactionId,
        this.totalBookingAmount,
        this.totalTaxAmount,
        this.totalDiscountAmount,
        this.serviceSchedule,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.subCategoryId,
        this.servicemanId,
        this.detail,
      });

  DashboardBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = json['total_booking_amount'];
    totalTaxAmount = json['total_tax_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    servicemanId = json['serviceman_id'];
    if (json['detail'] != null) {
      detail = <RecentOrderDetail>[];
      json['detail'].forEach((v) {
        detail!.add(RecentOrderDetail.fromJson(v));
      });
    }
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
    return data;
  }
}



class MonthlyStats {
  int? total;
  int? year;
  int? month;
  int? day;

  MonthlyStats({this.total, this.year, this.month, this.day});

  MonthlyStats.fromJson(Map<String, dynamic> json) {
    total = int.parse(json['total'].toString());
    year =int.parse( json['year'].toString());
    month = int.parse(json['month'].toString());
    day = int.parse(json['day'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}


class YearlyStats {
  int? total;
  int? year;
  int? month;

  YearlyStats({this.total, this.year, this.month});

  YearlyStats.fromJson(Map<String, dynamic> json) {
    total = int.parse(json['total'].toString());
    year = int.parse(json['year'].toString());
    month = int.parse(json['month'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}


class RecentOrderDetail {
  int? id;
  String? bookingId;
  String? serviceId;
  String? variantKey;
  num? serviceCost;
  int? quantity;
  num? discountAmount;
  num? taxAmount;
  num? totalCost;
  String? createdAt;
  String? updatedAt;
  num? campaignDiscountAmount;
  num? overallCouponDiscountAmount;
  Service? service;

  RecentOrderDetail(
      {int? id,
        String? bookingId,
        String? serviceId,
        String? variantKey,
        num? serviceCost,
        int? quantity,
        num? discountAmount,
        num? taxAmount,
        num? totalCost,
        String? createdAt,
        String? updatedAt,
        num? campaignDiscountAmount,
        num? overallCouponDiscountAmount,
        Service? service}) {
    if (id != null) {
      id = id;
    }
    if (bookingId != null) {
      bookingId = bookingId;
    }
    if (serviceId != null) {
      serviceId = serviceId;
    }
    if (variantKey != null) {
      variantKey = variantKey;
    }
    if (serviceCost != null) {
      serviceCost = serviceCost;
    }
    if (quantity != null) {
      quantity = quantity;
    }
    if (discountAmount != null) {
      discountAmount = discountAmount;
    }
    if (taxAmount != null) {
      taxAmount = taxAmount;
    }
    if (totalCost != null) {
      totalCost = totalCost;
    }
    if (createdAt != null) {
      createdAt = createdAt;
    }
    if (updatedAt != null) {
      updatedAt = updatedAt;
    }
    if (campaignDiscountAmount != null) {
      campaignDiscountAmount = campaignDiscountAmount;
    }
    if (overallCouponDiscountAmount != null) {
      overallCouponDiscountAmount = overallCouponDiscountAmount;
    }
    if (service != null) {
      service = service;
    }
  }

  RecentOrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    variantKey = json['variant_key'];
    serviceCost = json['service_cost'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    taxAmount = json['tax_amount'];
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    campaignDiscountAmount = json['campaign_discount_amount'];
    overallCouponDiscountAmount = json['overall_coupon_discount_amount'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_id'] = serviceId;
    data['variant_key'] = variantKey;
    data['service_cost'] = serviceCost;
    data['quantity'] = quantity;
    data['discount_amount'] = discountAmount;
    data['tax_amount'] = taxAmount;
    data['total_cost'] = totalCost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['campaign_discount_amount'] = campaignDiscountAmount;
    data['overall_coupon_discount_amount'] = overallCouponDiscountAmount;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Service {
  String? id;
  String? name;
  String? thumbnail;

  Service({String? id, String? name, String? thumbnail}) {
    if (id != null) {
      id = id;
    }
    if (name != null) {
      name = name;
    }
    if (thumbnail != null) {
      thumbnail = thumbnail;
    }
  }

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
