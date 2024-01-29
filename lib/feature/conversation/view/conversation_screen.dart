import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class ConversationScreen extends StatefulWidget {
  final String channelID;
  final String name;
  final String image;
  final String userType;
  final String? formNotification;

  const ConversationScreen({super.key, 
    required this.name,
    required this.image,
    required this.channelID,
    required this.userType,
    this.formNotification = ""
  });
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String phone ='';
  @override
  void initState() {
    Get.find<ConversationController>().resetControllerValue(widget.channelID);
    Get.find<ConversationController>().getConversation(widget.channelID,1);
    super.initState();

    if(widget.userType != ""){
      phone = "+${widget.userType}";
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
        leading: IconButton(
          onPressed: () {
            if(widget.formNotification == "fromNotification"){
              Get.offNamed(RouteHelper.getInboxScreenRoute());
            }else{
              Get.back();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColorLight,
            size: 20
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name,
                style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight)
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
            Text(phone,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColorLight)
            ),
          ],
        ),
        actions: [
          Padding(padding: const EdgeInsets.all(8.0),
            child: Container(height: 40, width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(image: widget.image),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall)
        ],
      ),

      body: GetBuilder<ConversationController>(

        builder: (conversationController) {
          String? customerID = Get.find<ProfileController>().userInfo.id;
          return conversationController.isFirst ?
          const ChattingShimmer() :
          Column(
            children: [
              conversationController.conversationList !=null && conversationController.conversationList!.isNotEmpty ?
              Expanded(
                child: ListView.builder(
                  controller: conversationController.messageScrollController,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  itemCount: conversationController.conversationList!.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    bool isRightMessage = conversationController.conversationList!.elementAt(index).userId == customerID;
                    return ConversationBubble(
                      conversationData:conversationController.conversationList!.elementAt(index),
                      isRightMessage: isRightMessage,
                    );
                  },
                ),
              ) :Expanded(child: Center(child: Text('no_conversation_found'.tr),)),
              conversationController.pickedImageFile != null && conversationController.pickedImageFile!.isNotEmpty ?
              Container(height: 90, width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return  Stack(
                      children: [
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(height: 80, width: 80,
                              child: Image.file(
                                File(conversationController.pickedImageFile![index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          child: InkWell(
                            child: const Icon(Icons.cancel_outlined, color: Colors.red),
                            onTap: () => conversationController.pickMultipleImage(true,index: index),
                          ),
                        ),
                      ],
                    );},
                  itemCount: conversationController.pickedImageFile!.length,
                ),
              ) : const SizedBox(),

              conversationController.otherFile != null ?
              Stack(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: 25,
                  child: Text(
                    conversationController.otherFile!.names.toString(),
                  ),
                ),
                Positioned(top: 0, right: 0,
                    child: InkWell(child: const Icon(Icons.cancel_outlined,
                        color: Colors.red),
                        onTap: () => conversationController.pickOtherFile(true)
                    )
                )
              ],) : const SizedBox(),

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,
                    right: Dimensions.paddingSizeSmall,
                    bottom: Dimensions.paddingSizeSmall,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0),
                      ),
                    ], color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20),),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Expanded(
                        child: TextField(
                          controller: conversationController.conversationController,
                          textCapitalization: TextCapitalization.sentences,
                          style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "type_here".tr,
                            hintStyle: ubuntuRegular.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (String newText) {

                          },
                        ),
                      ),

                      Row(
                        children: [
                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            child: InkWell(child: Image.asset(
                                Images.image, color: Get.isDarkMode?Colors.white:Colors.black),
                                onTap: () => conversationController.pickMultipleImage(false)
                            ),
                          ),

                          InkWell(child: Image.asset(Images.file, color: Get.isDarkMode?Colors.white:Colors.black),
                              onTap: () => conversationController.pickOtherFile(false)
                          ),

                          conversationController.isLoading ?
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 20,
                            width: 40,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).hoverColor,
                              ),
                            ),
                          ) :InkWell(
                            onTap: (){
                              if(conversationController.conversationController.text.isEmpty
                                  && conversationController.pickedImageFile!.isEmpty
                                  && conversationController.otherFile==null){
                                showCustomSnackBar("write_something".tr);
                              }
                              else if(conversationController.conversationController.text.isNotEmpty){
                                conversationController.sendMessage(widget.channelID);
                              }
                              conversationController.conversationController.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                              ),
                              child: Image.asset(
                                Images.sendMessage,
                                width: 25,
                                height: 25,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          );
        }),
    );
  }
}
