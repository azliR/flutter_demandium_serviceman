import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class ChannelList extends GetView<ConversationController> {
  final String? fromNotification;
  const ChannelList({Key? key, this.fromNotification}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: 'inbox'.tr,
        onBackPressed: (){
          if(fromNotification == "fromNotification"){
            Get.offNamed(RouteHelper.getInitialRoute());
          }else{
            Get.back();
          }
        },
      ),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
        onRefresh: () async {
         Get.find<ConversationController>().getChannelList(1,false);
         },
       child: GetBuilder<ConversationController>(
        initState:(_) async=> await Get.find<ConversationController>().getChannelList(1,false),
        builder: (conversationController){
          if(!conversationController.paginationLoading) {
            return Column(
            children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              conversationController.adminConversationModel!=null?
              ChannelItem(
                conversationUserModel: conversationController.adminConversationModel!,
                channelCreatedTime: conversationController.adminConversationModel!.createdAt!,
                isRead: 0,
              ): const SizedBox(),
              Expanded(
                child:controller.channelList!.isEmpty && conversationController.adminConversationModel==null?
                const SizedBox(
                    child: NoDataScreen(text: '',type: NoDataType.conversation,)

                ): ListView.builder(
                    controller: conversationController.channelScrollController,
                    itemCount: controller.channelList!.length,
                    itemBuilder: (context,index){
                      bool user =
                      ((controller.channelList![index].channelUsers![0].user != null && controller.channelList![index].channelUsers![0].user!.userType !='super-admin')
                          &&  (controller.channelList![index].channelUsers![1].user != null && controller.channelList![index].channelUsers![1].user!.userType !='super-admin'));
                      int? isRead;
                      if(user){
                        isRead = controller.channelList![index].channelUsers![0].user!.userType == "provider-serviceman" ?
                        controller.channelList![index].channelUsers![0].isRead! : controller.channelList![index].channelUsers![1].isRead!;
                      }
                      return user? ChannelItem(
                        conversationUserModel:  controller.channelList![index].channelUsers![0].user!.userType != "provider-serviceman" ?
                        controller.channelList![index].channelUsers![0] : controller.channelList![index].channelUsers![1],
                        channelCreatedTime: controller.channelList!.elementAt(index).updatedAt!,
                        isRead: isRead!,
                      ): const SizedBox();
                    }
                ),
              ),
              conversationController.isLoading ? Center(child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: CircularProgressIndicator(color: Theme.of(context).hoverColor)),
              ) : const SizedBox.shrink(),
            ],
          );
          }
          return const InboxShimmer();

        },
      ),
    ));
  }
}

class InboxShimmer extends StatelessWidget {
  const InboxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: const Duration(seconds: 3),
          interval: const Duration(seconds: 5),
          color: Theme.of(context).colorScheme.background,
          colorOpacity: 0,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            child: Row(children: [
              CircleAvatar(backgroundColor: Theme.of(context).shadowColor, radius: 20, child: const Icon(Icons.person)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Column(children: [
                    Container(height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          color: Theme.of(context).shadowColor),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
