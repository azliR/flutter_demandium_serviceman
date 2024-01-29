import 'package:get/get.dart';
import 'package:demandium_serviceman/feature/html/repository/html_repo.dart';
import '../controller/webview_controller.dart';

class HtmlBindings extends Bindings {@override
void dependencies(){
  Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
}
}
