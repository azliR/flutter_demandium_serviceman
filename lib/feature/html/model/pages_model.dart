import 'package:demandium_serviceman/data/model/response/notification_model.dart';

class PagesModel {
  String? responseCode;
  String? message;
  PagesContent? content;
  List<Errors>? errors;

  PagesModel({this.responseCode, this.message, this.content, this.errors});

  PagesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? PagesContent.fromJson(json['content']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PagesContent {
  AboutUs? aboutUs;
  AboutUs? termsAndConditions;
  AboutUs? privacyPolicy;
  AboutUs? refundPolicy;
  AboutUs? returnPolicy;
  AboutUs? cancellationPolicy;

  PagesContent(
      {this.aboutUs,
        this.termsAndConditions,
        this.privacyPolicy,
        this.refundPolicy,
        this.returnPolicy,
        this.cancellationPolicy});

  PagesContent.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'] != null
        ? AboutUs.fromJson(json['about_us'])
        : null;
    termsAndConditions = json['terms_and_conditions'] != null
        ? AboutUs.fromJson(json['terms_and_conditions'])
        : null;
    privacyPolicy = json['privacy_policy'] != null
        ? AboutUs.fromJson(json['privacy_policy'])
        : null;
    refundPolicy = json['refund_policy'] != null
        ? AboutUs.fromJson(json['refund_policy'])
        : null;
    returnPolicy = json['return_policy'];
    cancellationPolicy = json['cancellation_policy'] != null
        ? AboutUs.fromJson(json['cancellation_policy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aboutUs != null) {
      data['about_us'] = aboutUs!.toJson();
    }
    if (termsAndConditions != null) {
      data['terms_and_conditions'] = termsAndConditions!.toJson();
    }
    if (privacyPolicy != null) {
      data['privacy_policy'] = privacyPolicy!.toJson();
    }
    if (refundPolicy != null) {
      data['refund_policy'] = refundPolicy!.toJson();
    }
    data['return_policy'] = returnPolicy;
    if (cancellationPolicy != null) {
      data['cancellation_policy'] = cancellationPolicy!.toJson();
    }
    return data;
  }
}

class AboutUs {
  String? id;
  String? keyName;
  String? liveValues;
  String? settingsType;
  String? mode;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  AboutUs(
      {this.id,
        this.keyName,
        this.liveValues,
        this.settingsType,
        this.mode,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyName = json['key'];
    liveValues = json['value'];
    settingsType = json['type'];
    //mode = json['mode'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key_name'] = keyName;
    data['live_values'] = liveValues;
    data['settings_type'] = settingsType;
    data['mode'] = mode;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
