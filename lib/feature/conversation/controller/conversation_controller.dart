import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class ConversationController extends GetxController implements GetxService{
  final ConversationRepo conversationRepo;
  ConversationController({required this.conversationRepo});
  ///selected file to send to channel
  List <XFile>? _pickedImageFiles =[];
  List <XFile>? get pickedImageFile => _pickedImageFiles;


  FilePickerResult? _otherFile;
  FilePickerResult? get otherFile => _otherFile;


  File? _file;
  File? get file=> _file;
  PlatformFile? objFile;

  List<MultipartBody> _selectedImageList = [];
  List<MultipartBody> get selectedImageList => _selectedImageList;
  bool _paginationLoading = true;
  bool get paginationLoading => _paginationLoading;

  int? _messagePageSize;
  int? _messageOffset = 1;
  int? get messagePageSize => _messagePageSize;
  int? get messageOffset => _messageOffset;

  int? _channelPageSize;
  int? _channelOffset = 1;
  int? get channelPageSize => _channelPageSize;
  int? get channelOffset => _channelOffset;

  int? _pageSize;
  final int _offset = 1;

  bool _isFirst = false;
  bool get isFirst => _isFirst;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _name='';
  String get name => _name;
  String _image='';
  String get image => _image;


  ///channel list / inbox list to show in channel list screen
  List<ChannelData>? _channelList = [];
  List<ChannelData>? get channelList => _channelList;

  ///one to one conversation list
  List<ConversationData>? _conversationList;
  List<ConversationData>? get conversationList => _conversationList;

  ConversationUserModel? _adminConversationModel;
  ConversationUserModel? get adminConversationModel => _adminConversationModel;

  ///scroll controller to implement pagination
  final ScrollController channelScrollController = ScrollController();
  final ScrollController messageScrollController = ScrollController();
  int? get pageSize => _pageSize;
  int? get offset => _offset;

  var conversationController = TextEditingController();


  String _channelId = '';
  String get channelId => _channelId;

  String _userTypeImage ='';
  String get  userTypeImage => _userTypeImage;




  @override
  void onInit(){
    super.onInit();
    conversationController.text = '';
    channelScrollController.addListener(() {
      if (channelScrollController.position.pixels == channelScrollController.position.maxScrollExtent) {
        if (_channelOffset! < _channelPageSize!) {
          getChannelList(_channelOffset!+1,true);
        }
      }
    });

    messageScrollController.addListener(() {
      if (messageScrollController.position.pixels == messageScrollController.position.maxScrollExtent) {
        if (_messageOffset! < _messagePageSize!) {
          getConversation(_channelId,_messageOffset!+1, isFromPagination: true);
        }
      }
    });
  }

  void pickMultipleImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        _pickedImageFiles!.removeAt(index);
        _selectedImageList.removeAt(index);
      }
    }else {
      _pickedImageFiles = await ImagePicker().pickMultiImage();
      if (_pickedImageFiles != null) {

        for(int i =0; i< _pickedImageFiles!.length; i++){
          _selectedImageList.add(MultipartBody('files[$i]',_pickedImageFiles![i]));
        }
      }
    }
    update();
  }


  void pickOtherFile(bool isRemove) async {
    if(isRemove){
      _otherFile=null;
      _file = null;
    }else{
      _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
      if (_otherFile != null) {
        objFile = _otherFile!.files.single;
      }
    }
    update();
  }


  Future<void> getChannelListBasedOnReferenceId(int offset,String referenceId) async{
    _channelList = [];
    _isLoading = true;
    update();
     Response response = await conversationRepo.getChannelListBasedOnReferenceId(offset,referenceId);
     if(response.statusCode == 200){
       response.body['content']['data'].forEach((channel){
         _channelList!.add(ChannelData.fromJson(channel));
       });
       _isLoading = false;
     }else{
       ApiChecker.checkApi(response);
     }
     update();
  }

  Future<void> getChannelList(int offset, bool isFromPagination) async{
    _channelOffset = offset;

    //update();

    if(!isFromPagination){
      _channelList =[];
      _paginationLoading = true;
    }
    else{
      _isLoading = true;
    }
    Response response = await conversationRepo.getChannelList(offset);
    if(response.statusCode == 200){
      response.body['content']['data'].forEach((channel){
        _channelList!.add(ChannelData.fromJson(channel));
        _channelPageSize =response.body['content']['last_page'];
      });

      _channelList?.forEach((element) {
        if(element.channelUsers?[0].user?.userType=='super-admin'){
          _adminConversationModel = element.channelUsers?[0];
        }else if(element.channelUsers?[1].user?.userType=='super-admin'){
          _adminConversationModel = element.channelUsers?[1];
        }else{
          //_adminConversationModel=null;
        }
      });
    }else{
      ApiChecker.checkApi(response);
    }

    _paginationLoading = false;
    _isLoading = false;
    update();
  }



  Future<void> createChannel(String userID,String referenceID,{String? name,String? image,String? userType}) async{

    Get.dialog(const CustomLoader(),barrierDismissible: false);
    Response response = await conversationRepo.createChannel(userID,referenceID);
    Get.back();
    if(response.statusCode == 200){
      _isLoading = false;
      Get.toNamed(RouteHelper.getChatScreenRoute(response.body['content']['id'],name!,image!,userType!));

    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<void> getConversation(String channelID, int offset, {bool isConversation = true, bool isFromPagination = false}) async{
    _messageOffset = offset;
    if(isConversation){
      _isFirst = true;
    }

    Response response = await conversationRepo.getConversation(channelID, offset);
    if(response.statusCode == 200){
      getChannelList(1, false);

      if(!isFromPagination){
        _conversationList = [];
      }
      response.body['content']['data'].forEach((conversation){_conversationList!.add(ConversationData.fromJson(conversation));
      _messagePageSize =  response.body['content']['last_page'];
      _channelId = _conversationList![0].channelId!;
      });

    }else{

      ApiChecker.checkApi(response);
    }

    _isFirst = false;
    update();
  }



  Future<void> sendMessage(String channelID) async{
    _isLoading = true;
    update();
    Response response = await conversationRepo.sendMessage(conversationController.value.text,channelID ,_selectedImageList, objFile);
    if(response.statusCode == 200){
      getConversation(channelID,1,isConversation: false);
      conversationController.text='';
      _pickedImageFiles = [];
      _selectedImageList = [];
      _otherFile=null;
      objFile=null;
      _file=null;
    }
    else if(response.statusCode == 400){
      String message = response.body['errors'][0]['message'];
      if(message.contains("png  jpg  jpeg  csv  txt  xlx  xls  pdf")){
        message = "the_files_types_must_be";
      }
      if(message.contains("failed to upload")){
        message = "failed_to_upload";
      }
      _pickedImageFiles = [];
      _selectedImageList = [];
      _otherFile=null;
      objFile=null;
      _file=null;
      showCustomSnackBar(message.tr);
    }
    else{
      _pickedImageFiles = [];
      _selectedImageList = [];
      _otherFile=null;
      objFile=null;
      _file=null;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  void downloadFile(String url, String dir) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
  }

  void setChatNameImg(String name,String img){
    _name=name;
    _image=img;
    update();
  }

  void setUserImageType(String userType){
    _userTypeImage = userType;
    update();
  }

  void resetControllerValue(String channelId){
    _pickedImageFiles = [];
    conversationController.text = "";
    _channelId = channelId;
  }
}