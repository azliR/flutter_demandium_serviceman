import 'package:get/get.dart';
import 'package:demandium_serviceman/feature/conversation/controller/conversation_controller.dart';
import 'package:demandium_serviceman/feature/conversation/repo/conversation_repo.dart';


class ConversationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
  }
}