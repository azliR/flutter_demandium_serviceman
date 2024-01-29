import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';




enum BooingListStatus{accepted,ongoing}

class BookingListController extends GetxController  implements GetxService{
  final BookingListRepo bookingListRepo;
  BookingListController({required this.bookingListRepo});

  final ScrollController scrollController = ScrollController();
  bool _isLoading= false;
  bool get isLoading => _isLoading;

  bool _isFirst= true;
  bool  get isFirst=> _isFirst;

  bool _isPaginationLoading= false;
  bool get isPaginationLoading => _isPaginationLoading;



  int _bookingListPageSize = 1;
  int _offset = 1;
  int get offset => _offset;

  List<BookingItemModel> _bookingList =[];
  List<BookingItemModel> get bookingList => _bookingList;
  String ? requestType;

  BooingListStatus get bookingStatusState => _bookingStatusState;

  var _bookingStatusState = BooingListStatus.accepted;

  void updateBookingStatusState(BooingListStatus booingListStatus){
      _bookingStatusState=booingListStatus;
      update();
    getBookingList(_bookingStatusState.name.toLowerCase(),1);

  }
  @override
  void onInit(){
    _bookingStatusState = BooingListStatus.accepted;
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_offset <= _bookingListPageSize) {
          _isPaginationLoading=true;
          bottomLoader();
          update();
          getBookingList( _bookingStatusState.name.toLowerCase(),_offset+1,isFromPagination: true);
        }else{
        }
      }
    });
  }


  Future<void> getBookingList(String requestType, int offset, {bool isFromPagination = false})async{
     _offset = offset;
    if(!isFromPagination){
      _bookingList=[];
      _isFirst = true;
    }
     update();
    Response response = await bookingListRepo.getBookingList(requestType.toLowerCase(), offset);
    if(response.statusCode == 200){
      _isLoading = false;
      _isFirst = false;
      response.body['content']['data'].forEach((item)=> _bookingList.add(BookingItemModel.fromJson(item)));
      _bookingListPageSize = response.body['content']['last_page'];
    }else{
      _isFirst = false;
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }
  void bottomLoader(){
    _isFirst = false;
    _isLoading = true;
    update();
  }

}