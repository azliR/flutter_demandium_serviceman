class BookingPrice {
  String? responseCode;
  String? message;
  List<BookingPriceItem>? bookingPriceContent;
  
  BookingPrice({this.responseCode, this.message, this.bookingPriceContent});

  BookingPrice.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['content'] != null) {
      bookingPriceContent = <BookingPriceItem>[];
      json['content'].forEach((v) {
        bookingPriceContent!.add(BookingPriceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (bookingPriceContent != null) {
      data['content'] = bookingPriceContent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingPriceItem {
  String? serviceId;
  String? serviceName;
  String? variantKey;
  int? quantity;
  double? serviceCost;
  double? totalDiscountAmount;
  String? couponCode;
  double? taxAmount;
  double? totalCost;
  String? zoneId;

  BookingPriceItem(
      {this.serviceId,
        this.serviceName,
        this.variantKey,
        this.quantity,
        this.serviceCost,
        this.totalDiscountAmount,
        this.couponCode,
        this.taxAmount,
        this.totalCost,
        this.zoneId});

  BookingPriceItem.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    quantity = int.tryParse(json['quantity'].toString());
    serviceCost = double.tryParse(json['service_cost'].toString());
    totalDiscountAmount = double.tryParse(json['total_discount_amount'].toString());
    couponCode = json['coupon_code'];
    taxAmount = double.tryParse(json['tax_amount'].toString());
    totalCost = double.tryParse(json['total_cost'].toString());
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['variant_key'] = variantKey;
    data['quantity'] = quantity;
    data['service_cost'] = serviceCost;
    data['total_discount_amount'] = totalDiscountAmount;
    data['coupon_code'] = couponCode;
    data['tax_amount'] = taxAmount;
    data['total_cost'] = totalCost;
    data['zone_id'] = zoneId;
    return data;
  }
}
