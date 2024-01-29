import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:demandium_serviceman/feature/notifications/model/notofication_model.dart';
import 'package:demandium_serviceman/feature/notifications/repository/notification_repo.dart';



class NotificationController extends GetxController implements GetxService{
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  NotificationModel? _notificationModel;
  NotificationModel? get notificationModel => _notificationModel;
  List<String> dateList = [];
  List allNotificationList=[];
  List<dynamic> notificationList=[];


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _paginationLoading = false;
  bool get paginationLoading => _paginationLoading;

  int _notificationCount = 0;
  int get unseenNotificationCount => _notificationCount;

  int _totalNumberOfNotification=0;
  int get totalNumberOfNotification => _totalNumberOfNotification;

  int? _pageSize = 1;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent/2 < scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getNotifications(offset+1, reload: false);
        }
      }
    });
  }

  Future<void> getNotifications(int offset, {bool reload = true,bool saveNotificationCount=true})async{
    _offset = offset;
    if(reload){
      dateList =[];
      notificationList =[];
      allNotificationList =[];
      _isLoading =true;
    }
    else {
      _paginationLoading = true;
    }

    Response response = await notificationRepo.getNotification(offset);
    if(response.statusCode == 200){

      allNotificationList =[];
      _totalNumberOfNotification = 0;
      _notificationModel =  NotificationModel.fromJson(response.body);

      _pageSize = response.body['content']['last_page'];

      _totalNumberOfNotification  = notificationModel!.content!.total??0;

      getNotificationCount();
      if(saveNotificationCount){
        setNotificationCount(_totalNumberOfNotification);
      }
      for (var data in notificationModel!.content!.data!) {
        allNotificationList.add(data);
      }

      for (var data in notificationModel!.content!.data!) {
        if(!dateList.contains(DateConverter.dateStringMonthYear(DateTime.tryParse(data.createdAt!)))) {
          dateList.add(DateConverter.dateStringMonthYear(DateTime.tryParse(data.createdAt!)));
        }
      }

      for(int i=0;i< dateList.length;i++){
        notificationList.add([]);
        for (var element in allNotificationList) {
          if(dateList[i]== DateConverter.dateStringMonthYear(DateTime.tryParse(element.createdAt!))){
            notificationList[i].add(element);
          }
        }
      }

    } else{
      ApiChecker.checkApi(response);
    }
    _paginationLoading = false;
    _isLoading =false;
    update();
  }

  void getNotificationCount() async {
    _notificationCount = (await notificationRepo.getNotificationCount())!;
    if(_totalNumberOfNotification>_notificationCount){
      _notificationCount = _totalNumberOfNotification - _notificationCount;
    }else{
      _notificationCount =0;
    }

    update();
  }

  void resetNotificationCount(){
    _notificationCount = 0;
    update();
  }
  void setNotificationCount(int count){
    notificationRepo.setNotificationCount(count);
  }
}