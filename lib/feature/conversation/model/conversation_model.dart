import 'package:demandium_serviceman/feature/notifications/model/notofication_model.dart';

import 'conversation_user.dart';

///one to one conversation model from server
class ConversationModel {
  String? responseCode;
  String? message;
  ConversationContent? content;

  ConversationModel({this.responseCode, this.message, this.content});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? ConversationContent.fromJson(json['content']) : null;
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

class ConversationContent {
  int? currentPage;
  List<ConversationData>? conversationList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ConversationContent(
      {this.currentPage,
        this.conversationList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ConversationContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      conversationList = <ConversationData>[];
      json['data'].forEach((v) {
        conversationList!.add(ConversationData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (conversationList != null) {
      data['data'] = conversationList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

///list of message
class ConversationData {
  String? id;
  String? channelId;
  String? message;
  String? userId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  ConversationUser? user;
  List<ConversationFile>? conversationFile;

  ConversationData(
      {this.id,
        this.channelId,
        this.message,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.conversationFile
      });

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channel_id'];
    message = json['message'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? ConversationUser.fromJson(json['user']) : null;

    if (json['conversation_files'] != null) {
      conversationFile = <ConversationFile>[];
      json['conversation_files'].forEach((v) {
        conversationFile!.add(ConversationFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channel_id'] = channelId;
    data['message'] = message;
    data['user_id'] = userId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    if (conversationFile != null) {
      data['conversation_files'] = conversationFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationFile {
  String? id;
  String? conversationId;
  String? fileName;
  String? fileType;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ConversationFile(
      {this.id,
        this.conversationId,
        this.fileName,
        this.fileType,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ConversationFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conversation_id'] = conversationId;
    data['file_name'] = fileName;
    data['file_type'] = fileType;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

