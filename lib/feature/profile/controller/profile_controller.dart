import 'package:demandium_serviceman/feature/profile/model/userinfo_model.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

enum EditProfileTabControllerState {generalInfo,accountIno}
class ProfileController extends GetxController implements GetxService {

  @override
  void onInit() {
    super.onInit();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  final UserRepo userRepo;
  ProfileController({required this.userRepo});

  User _user = User();
  User get userInfo => _user;

  ProfileContent? _contents;
  ProfileContent? get contents => _contents;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  XFile? _pickedFile ;
  XFile? get pickedFile => _pickedFile;

  String? _days;
  String? get totalDays => _days;

  String? _zoneId;
  String? get zoneId => _zoneId;

  String? password;

  TabController? tabController;
  var editProfilePageCurrentState = EditProfileTabControllerState.generalInfo;

  TextEditingController? passController,confirmPassController,emailController,firstNameController,lastNameController;
  final GlobalKey<FormState> passUpdateKey = GlobalKey<FormState>();

  void updatePageCurrentState(EditProfileTabControllerState editProfileTabControllerState){
    editProfilePageCurrentState = editProfileTabControllerState;
    update();
  }

  String ? validatePassword(String value){
    if(value.length <8){
      password=value;
      return "password_should_be".tr;
    }
    return null;
  }

  String ? confirmPassword(String value){
    if(value.length <8){
      return "password_should_be".tr;
    }
    return null;
  }

  Future<ResponseModel> getUserInfo() async {
    _isLoading=true;
    ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _user = User.fromJson(response.body['content']['user']);
      _contents =ProfileContent.fromJson(response.body['content']);
      _days=DateConverter.countDays(DateTime.tryParse(_contents?.createdAt!??""));
      responseModel = ResponseModel(true, 'successful');
      _zoneId = _contents?.provider?.zoneId!;
      emailController!.text = _user.email??"";
      firstNameController!.text = _user.firstName??"";
      lastNameController!.text = _user.lastName??"";
    } else {
      responseModel = ResponseModel(false, response.statusText);
      ApiChecker.checkApi(response);
    }
    _isLoading=false;
    update();
    return responseModel;
  }

  Future<void> updateProfile() async {
    _isLoading = true;
    update();

    Response response = await userRepo.updateProfile(
      firstNameController!.text.toString(),
        lastNameController!.text.toString(),
        emailController!.text.toString(),
        _pickedFile
    );
    if(response.statusCode==200){
         getUserInfo();
        showCustomSnackBar("profile_updated_successfully".tr,isError: false);
    }
    else{
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }


  Future<void> updatePassword() async{
    Map<String,String> body ={
      'password': passController!.text,
      'confirm_password' : confirmPassController!.text,
    };
    _isLoading = true;
    update();
    Response response = await userRepo.updatePassword(body);
      if(response.statusCode == 200){
        showCustomSnackBar("password_successfully_updated".tr,isError: false);
        passController!.text="";
        confirmPassController!.text="";
      } else{
        ApiChecker.checkApi(response);
      }
    _isLoading = false;
    update();
  }

  void pickImage({bool removePickedProfileImage = false}) async {
    if(removePickedProfileImage){
      _pickedFile =null;
    }else{
      _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    }
    update();
  }




}