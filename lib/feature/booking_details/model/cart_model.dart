import 'package:demandium_serviceman/common_model/service_details_model.dart';

class CartModel {
  String? id;
  bool? isNewItem;
  String? serviceId;
  String? categoryId;
  String? subCategoryId;
  String? serviceName;
  String? variantKey;
  double? serviceCost;
  String? serviceThumbnail;
  int? quantity;
  double? discountAmount;
  double? campaignDiscountAmount;
  double? couponDiscountAmount;
  double? taxAmount;
  double? totalCost;
  ServiceModel? service;

  CartModel({
    required this.id,
    required  this.serviceId,
    required this.isNewItem,
    this.categoryId,
    this.subCategoryId,
    required this.serviceName,
    required this.variantKey,
    required this.quantity,
    required this.serviceThumbnail,
    required  this.serviceCost,
    required this.totalCost,
    this.taxAmount,
    this.campaignDiscountAmount,
    this.couponDiscountAmount,
    this.discountAmount,
    this.service,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    variantKey = json['variant_key'];
    serviceCost = json['service_cost'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    campaignDiscountAmount = json['campaign_discount'];
    couponDiscountAmount = json['coupon_discount'];
    taxAmount = json['tax_amount'];
    totalCost = json['total_cost'];
    service = json['service'] != null ? ServiceModel.fromJson(json['service']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['variant_key'] = variantKey;
    data['service_cost'] = serviceCost;
    data['quantity'] = quantity;
    data['discount_amount'] = discountAmount;
    data['campaign_discount'] = campaignDiscountAmount;
    data['coupon_discount'] = couponDiscountAmount;
    data['tax_amount'] = taxAmount;
    data['total_cost'] = totalCost;
    data['service'] = service;
    data['service'] = service?.toJson();
    return data;
  }
}
