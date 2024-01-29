import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'dart:isolate';
import 'dart:ui';


class ConversationBubble extends StatefulWidget {
  final ConversationData conversationData;
  final bool isRightMessage;

  const ConversationBubble({super.key, required this.conversationData, required this.isRightMessage});

  @override
  State<ConversationBubble> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationBubble> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState((){ });
    });

    //FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context){

    return Column(
          crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(20, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 20, 5),
              child: Column(
                crossAxisAlignment:
                widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  //Name
                  widget.conversationData.user!=null?Row(
                    mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      widget.isRightMessage ? Text('${Get.find<ProfileController>().userInfo.firstName}'
                          ' ${Get.find<ProfileController>().userInfo.lastName}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall)) :
                        widget.conversationData.user!.provider == null ?
                        Text('${widget.conversationData.user!.firstName!} ${widget.conversationData.user!.lastName!}',
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall)):
                        Text(widget.conversationData.user!.provider!.companyName!,
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    ],
                  ):const SizedBox(),
                  Gaps.verticalGapOf(Dimensions.fontSizeExtraSmall),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [

                      widget.isRightMessage
                          ? const SizedBox()
                          : Column(children: [
                        ClipRRect(borderRadius: BorderRadius.circular(50),
                            child: widget.conversationData.user!.userType == 'customer' ?
                            CustomImage(
                                height: 30,
                                width: 30,
                                image:
                                '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                '${AppConstants.customerProfileImagePath}'
                                    '${widget.conversationData.user!=null?widget.conversationData.user!.profileImage:''}'
                            ) :

                            widget.conversationData.user!.userType == 'super-admin' ?
                            CustomImage(
                                height: 30,
                                width: 30,
                                image:
                                '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                '${AppConstants.adminProfileImagePath}'
                                    '${widget.conversationData.user!=null?widget.conversationData.user!.profileImage:''}'
                            ) :
                            widget.conversationData.user!.userType == 'provider-admin' ?
                            CustomImage(height: 30, width: 30, image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                '/provider/logo/${widget.conversationData.user!=null? widget.conversationData.user!.provider!.logo:''}'):
                                const CustomImage(image: '',height: 30,width: 30,)
                        ),
                      ],
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      //Message body
                      Flexible(
                        child: Column(
                          crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if(widget.conversationData.message != null) Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: widget.isRightMessage? Theme.of(context).primaryColor.withOpacity(0.1) :  Theme.of(context).primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(widget.conversationData.message != null?Dimensions.paddingSizeDefault:0),
                                  child: Text(widget.conversationData.message??'',style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.displayLarge!.color)),
                                ),
                              ),
                            ),
                            if( widget.conversationData.conversationFile!.isNotEmpty) const SizedBox(height: Dimensions.paddingSizeSmall),
                            widget.conversationData.conversationFile!.isNotEmpty?
                            Directionality(
                              textDirection: widget.isRightMessage  && Get.find<LocalizationController>().isLtr?
                              TextDirection.rtl: !Get.find<LocalizationController>().isLtr && !widget.isRightMessage? TextDirection.rtl: TextDirection.ltr,
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisCount: ResponsiveHelper.isTab(context)?5:3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.conversationData.conversationFile!.length,
                                itemBuilder: (BuildContext context, index){
                                  return widget.conversationData.conversationFile![index].fileType == 'png' || widget.conversationData.conversationFile![index].fileType == 'jpg'?
                                  InkWell(
                                    onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(imageUrl: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}'), ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child:
                                      FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder, height: 100, width: 100, fit: BoxFit.cover,
                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}',
                                        imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 100, width: 100, fit: BoxFit.cover),
                                      ),
                                    ),
                                  ) : InkWell(
                                    onTap : () async {
                                      final status = await Permission.storage.request();
                                      if(status.isGranted){
                                        Directory? directory = Directory('/storage/emulated/0/Download');
                                        if (!await directory.exists()) directory = await getExternalStorageDirectory();
                                        Get.find<ConversationController>().downloadFile('${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}',directory!.path);
                                      }else{
                                      }
                                    },

                                    child: Container(height: 50,width: 50,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).hintColor),
                                      child: Stack(
                                        children: [
                                          Center(child: SizedBox(width: 50, child: Image.asset(Images.folder))),
                                          Center(
                                            child: Text('${widget.conversationData.conversationFile![index].fileName}'.substring(widget.conversationData.conversationFile![index].fileName!.length-7),
                                              maxLines: 5, overflow: TextOverflow.clip,),
                                          )],
                                      )),
                                  );
                                }),
                            ):const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      widget.isRightMessage ?
                      ClipRRect(borderRadius: BorderRadius.circular(50),
                          child: CustomImage(height: 30, width: 30,
                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''/serviceman/profile/${widget.conversationData.user !=null?
                              widget.conversationData.user!.profileImage:''}'))
                          : const SizedBox(),
                    ],
                  ),
                  Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
                ],
              ),
            ),

            Padding(
              padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(5, 5, 50, 5) : const EdgeInsets.fromLTRB(50, 5, 5, 5),
              child: Text(textDirection: TextDirection.ltr, DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(widget.conversationData.createdAt!)),style: const TextStyle(fontSize: 7),)
            ),
            //Text("Hello"),

          ],
        );



  }
}
