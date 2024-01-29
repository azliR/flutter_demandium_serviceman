import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium_serviceman/data/provider/client_api.dart';
import 'package:demandium_serviceman/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';


class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.profileInfoUrl);
  }

  Future<Response> updateProfile(String fName,String lName,String email,XFile? profileImage) async {
    return await apiClient.postMultipartData(
        AppConstants.updateProfileUrl,{
      "email":email,
      "first_name":fName,
      "last_name":lName,
      "_method":"put"
    },[],profileImage!=null?MultipartBody('profile_image', profileImage):null
    );
  }

  Future<Response> updatePassword(Map<String,String> field,) async {
    return await apiClient.putData(AppConstants.updatePasswordUrl, field);
  }
}