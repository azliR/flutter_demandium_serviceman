import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class BookingHistoryController extends GetxController implements GetxService{
  final BookingHistoryRepo bookingHistoryRepo;
  BookingHistoryController({required this.bookingHistoryRepo});

  bool _isLoading= false;
  bool _isFirst= false;
  int _selectedIndex = 0;
  int get currentIndex =>_selectedIndex;

  void updateIndex(int index){
    _selectedIndex = index;
    update();
  }

  final ScrollController scrollController = ScrollController();
  List<String> bookingHistoryStatus =["All","Completed","Canceled",];
  List<BookingItemModel> _bookingReqList =[];
  List<BookingItemModel> get bookingList => _bookingReqList;
  bool get isLoading => _isLoading;
  bool get isFirst => _isFirst;
  bool _isPaginationLoading= false;
  int _bookingListPageSize = 1;
  int _offset = 1;
  int get offset => _offset;
  bool get isPaginationLoading => _isPaginationLoading;


  @override
  void onInit(){
    super.onInit();
    getBookingHistory('all',1);
    updateIndex(0);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_offset <= _bookingListPageSize) {
          _isPaginationLoading=true;
          update();
          getBookingHistory(bookingHistoryStatus[_selectedIndex],_offset+1,isFromPagination: true);
        }else{
        }
      }
    });
  }


  Future<void> getBookingHistory(String requestType, int offset, {bool isFromPagination = false})async{
    _isLoading = true;
    _isFirst = false;
    _offset = offset;
    if(!isFromPagination){
      _isFirst = true;
      _bookingReqList=[];
    }
    update();

    Response response = await bookingHistoryRepo.getBookingList(requestType.toLowerCase(),offset);
    if(response.statusCode == 200){
      if(!isFromPagination){
        _bookingReqList=[];
      }
      List<dynamic> bookingList = response.body['content']['data'];
      _bookingListPageSize = response.body['content']['last_page'];
      for (var serviceman in bookingList) {
        _bookingReqList.add(BookingItemModel.fromJson(serviceman));
      }
      _isLoading = false;
      _isFirst = false;
      update();
    } else{
      ApiChecker.checkApi(response);
      _isLoading = false;
      _isFirst = false;
      update();
    }
    update();
  }
}