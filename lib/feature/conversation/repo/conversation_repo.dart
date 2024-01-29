import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class ConversationRepo {

  final ApiClient apiClient;
  ConversationRepo({required this.apiClient});


  Future<Response> createChannel(String userID,String referenceID) async {
    return await apiClient.postData(
        AppConstants.createChannelUrl,
        {"to_user": userID,"reference_id":referenceID,
          "reference_type":"booking_id"
        }
    );
  }

  Future<Response> getChannelList(int offset) async {
    return await apiClient.getData('${AppConstants.getChannelList}?limit=${Get.find<SplashController>()
        .configModel.content!.paginationLimit}&offset=$offset'
    );
  }

  Future<Response> getChannelListBasedOnReferenceId(int offset,String referenceID) async {

    return await apiClient.getData(
      '${AppConstants.getChannelList}offset=$offset&reference_id=$referenceID&reference_type=booking_id',
    );
  }

  Future<Response> getConversation(String channelID,int offset) async {
    return await apiClient.getData('${AppConstants.getConversation}?channel_id=$channelID&offset=$offset');
  }
  Future<Response> sendMessage(String message,String channelID, List<MultipartBody> file, PlatformFile? platformFile ) async {
    return await apiClient.postMultipartData(
        AppConstants.sendMessage,
        {"message": message,"channel_id" : channelID},
        file , null,
        otherFile: platformFile
    );
  }
}