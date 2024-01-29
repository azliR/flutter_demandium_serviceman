import 'package:demandium_serviceman/common_model/service_details_model.dart';
import 'package:demandium_serviceman/feature/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PriceConverter {

  static String currencySymbol ='';
  static String currencySymbolValue ='';
  static String getCurrency( BuildContext context) {
    currencySymbol =  Get.find<SplashController>().configModel.content?.currencySymbol ?? "";
    return currencySymbol;
  }

  static String convertPrice(double? price, {double? discount, String? discountType, bool isShowLongPrice = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isRightSide = Get.find<SplashController>().configModel.content?.currencySymbolPosition == 'right';
    return isShowLongPrice == true ?'${isRightSide ? '' : currencySymbol}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel.content!.currencyDecimalPoint!))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} '
        '${isRightSide ? currencySymbol : ''}' :  longToShortPrice('${isRightSide ? '' : currencySymbol}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel.content!.currencyDecimalPoint!))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} '
        '${isRightSide ? currencySymbol : ''}');

  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : currencySymbol} OFF';
  }

  static Discount _getDiscount(List<ServiceDiscount>? serviceDiscountList, double? discountAmount, String? discountAmountType) {
    ServiceDiscount? serviceDiscount = (serviceDiscountList != null && serviceDiscountList.isNotEmpty) ?serviceDiscountList.first : null;
    if(serviceDiscount != null){
      double? getDiscount = serviceDiscount.discount?.discountAmount;
      if(getDiscount! > serviceDiscount.discount!.maxDiscountAmount! && serviceDiscount.discount!.discountType == 'percent') {
        getDiscount = serviceDiscount.discount!.maxDiscountAmount!;
      }
      discountAmount = (discountAmount! + getDiscount);
      discountAmountType = serviceDiscount.discount!.discountAmountType!;
    }

    return Discount(discountAmount: discountAmount, discountAmountType: discountAmountType);
  }

  static Discount discountCalculation(ServiceModel service, {bool addCampaign = false}) {
    double? discountAmount = 0;
    String? discountAmountType;

    if(service.serviceDiscount != null && service.serviceDiscount!.isNotEmpty) {

      Discount discount =  _getDiscount(service.serviceDiscount, discountAmount, discountAmountType);
      discountAmount = discount.discountAmount;

      discountAmountType = discount.discountAmountType;

    }else if(service.campaignDiscount != null && service.campaignDiscount!.isNotEmpty && addCampaign) {

      Discount discount =  _getDiscount(service.campaignDiscount, discountAmount, discountAmountType);
      discountAmount = discount.discountAmount;
      discountAmountType = discount.discountAmountType;
    }
    return Discount(discountAmount: discountAmount, discountAmountType: discountAmountType);
  }

  static String longToShortPrice(String price){
    return price.length > 15 ?
    "${price.substring(0, 12)}.......${price.substring(price.length - 1,price.length)}":
    price;
  }

}