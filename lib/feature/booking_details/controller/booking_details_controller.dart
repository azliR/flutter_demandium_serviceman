import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


enum BookingDetailsTabControllerState {bookingDetails,status}

class BookingDetailsController extends GetxController implements GetxService {
  final BookingDetailsRepo bookingDetailsRepo;
  BookingDetailsController({required this.bookingDetailsRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _otp = '';
  String get otp => _otp;

  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;

  double _invoiceGrandTotal = 0.0;
  double get invoiceGrandTotal => _invoiceGrandTotal;

  String _dropDownValue= "";
  String get dropDownValue => _dropDownValue;

  ScrollController scrollController  = ScrollController();
  ScrollController completedServiceImagesScrollController  = ScrollController();

  BookingDetailsContent? _bookingDetailsContent;
  BookingDetailsContent? get bookingDetailsContent => _bookingDetailsContent;

  bool _showPhotoEvidenceField = false;
  bool get showPhotoEvidenceField => _showPhotoEvidenceField;

  List<XFile> _photoEvidence = [];
  List<XFile> get pickedPhotoEvidence => _photoEvidence;

  bool _hideResendButton = false;
  bool get hideResendButton => _hideResendButton;

  final List<MultipartBody> _selectedIdentityImageList = [];
  List<MultipartBody> get selectedIdentityImageList => _selectedIdentityImageList;

  int _providerServicemanCanCancelBooking = 0;
  int get providerServicemanCanCancelBooking => _providerServicemanCanCancelBooking;

  int _providerServicemanCanEditBooking = 0;
  int get providerServicemanCanEditBooking => _providerServicemanCanEditBooking;

  var bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'booking_details'.tr),
    Tab(text: 'status'.tr),
  ];

  final List<String> statusTypeList = [ "ongoing", "completed" , "canceled"];

  List<InvoiceItem> _invoiceItems =[];
  List<InvoiceItem> get invoiceItems => _invoiceItems;

  List<double> _unitTotalCost =[];
  List<double> get unitTotalCost => _unitTotalCost;

  double _allTotalCost = 0;
  double _totalDiscount = 0;

  double _totalDiscountWithCoupon = 0;
  double get totalDiscountWithCoupon => _totalDiscountWithCoupon;

  double get allTotalCost => _allTotalCost;
  double get totalDiscount => _totalDiscount;



  Future<void> getBookingDetailsData(String bookingID,{bool loadingFalse=false}) async {
    _invoiceGrandTotal=0;
    _invoiceItems=[];

    _isLoading = true;
    _bookingDetailsContent = null;
    if(loadingFalse == true){
      _invoiceItems=[];
      _isLoading = false;
    }
    update();

    Response response = await bookingDetailsRepo.getBookingDetailsData(bookingID);
    if(response.statusCode == 200){
      _invoiceItems = [];
      _unitTotalCost = [];
      _invoiceItems = [];
      _allTotalCost = 0;

      _bookingDetailsContent = BookingDetailsContent.fromJson(response.body['content']['booking']);

      if(_bookingDetailsContent != null && _bookingDetailsContent?.subCategoryId != null){
        Get.find<BookingEditController>().getServiceListBasedOnSubcategory(subCategoryId : _bookingDetailsContent!.subCategoryId!);
      }

      _providerServicemanCanCancelBooking = response.body['content']['provider_serviceman_can_cancel_booking'];
      _providerServicemanCanEditBooking = response.body['content']['provider_serviceman_can_edit_booking'];
      _hideCanceledOption();

      for (var element in _bookingDetailsContent!.bookingDetails!) {
        _unitTotalCost.add( element.serviceCost! * element.quantity!);
      }

      if(_bookingDetailsContent != null){
        _dropDownValue = _bookingDetailsContent?.bookingStatus??"";
        Get.find<BookingEditController>().initializedControllerValue(_bookingDetailsContent!);
      }

      for (var element in _unitTotalCost) {
        _allTotalCost=_allTotalCost + element;
      }

      double? discount= _bookingDetailsContent!.totalDiscountAmount ?? 0;
      double? campaignDiscount= double.tryParse(_bookingDetailsContent!.totalCampaignDiscountAmount!);
      _totalDiscount = (discount + campaignDiscount!);
      _totalDiscountWithCoupon = discount+campaignDiscount + (double.tryParse(_bookingDetailsContent!.totalCouponDiscountAmount!)!);

      for (var element in _bookingDetailsContent!.bookingDetails!) {
        double discountAmount = element.discountAmount! + (element.campaignDiscountAmount!) + (element.overallCouponDiscountAmount!);
        _invoiceItems.add(
            InvoiceItem(
              discountAmount: discountAmount.toPrecision(2),
              tax: element.taxAmount!.toPrecision(2),
              unitAllTotal: element.totalCost!.toPrecision(2),
              quantity: element.quantity!,
              serviceName: "${element.serviceName?? 'service_deleted'.tr }"
                  "\n${element.variantKey?.replaceAll('-', ' ').capitalizeFirst ?? ' '}" ,
              unitPrice: element.serviceCost!.toPrecision(2),
            )
        );
      }
      Get.find<BookingEditController>().getServiceListBasedOnSubcategory(subCategoryId: _bookingDetailsContent?.subCategoryId ?? "");
    }
    else{

    }
    _isLoading = false;
    update();
  }

  Future<bool> sendBookingOTPNotification(String? bookingId, {bool shouldUpdate = true}) async {
    if(shouldUpdate){
      _hideResendButton = true;
      update();
    }
    Response response = await bookingDetailsRepo.sendBookingOTPNotification(bookingId);
    bool isSuccess;
    if(response.statusCode == 200) {
      isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      isSuccess = false;
    }
    _hideResendButton = false;
    update();
    return isSuccess;
  }


  void changeBookingStatus(String bookingId, String bookingStatus,{bool isBack = false} ) async{
    _isUpdate = true;
    update();

    List<MultipartBody> multiParts = [];
    for(XFile file in _photoEvidence) {
      multiParts.add(MultipartBody('evidence_photos[]', file));
    }

    if(bookingStatus == 'ongoing' && _dropDownValue =='canceled'){
      showCustomSnackBar('service_ongoing_can_not_cancel_booking'.tr);
    }
    else{
      Response response = await bookingDetailsRepo.changeBookingStatus(bookingId,_dropDownValue, otp , multiParts);
      if(response.statusCode==200 && response.body["response_code"]=="default_200"){

        getBookingDetailsData(bookingId,loadingFalse: true);

        if(isBack){
          Get.back();
        }
        showCustomSnackBar(response.body['message'], isError: false);
      }
      else{
        showCustomSnackBar(response.body['message'] ?? response.statusText);
      }
    }
    _isUpdate = false;
    update();
  }

  void changePaymentStatus(String bookingId,String paymentStatus) async {
    Response response = await bookingDetailsRepo.changePaymentStatus(bookingId,paymentStatus);
    if(response.statusCode == 200){
      showCustomSnackBar('successfully_paid'.tr,isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
    }
    update();
  }

  void changePhotoEvidenceStatus({bool isUpdate = true , bool status = false}){
    _showPhotoEvidenceField = status;
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.ease);
    if(isUpdate) {
      update();
    }
  }

  void updateServicePageCurrentState(BookingDetailsTabControllerState bookingDetaisTabControllerState){
    bookingPageCurrentState = bookingDetaisTabControllerState;
    update();
  }

  void setSelectedValue(String value){
    _dropDownValue=value;
    update();
  }


  Future<void> pickPhotoEvidence({required bool isRemove, required bool isCamera}) async {
    if(isRemove) {
      _photoEvidence = [];
      _showPhotoEvidenceField = false;
    }else {
      XFile? xFile = await ImagePicker().pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery, imageQuality: 50);
      if(xFile != null) {
        _photoEvidence.add(xFile);
        if(Get.isDialogOpen!){
          Get.back();
        }
        changePhotoEvidenceStatus(isUpdate: false, status: true);
        //completedServiceImagesScrollController.jumpTo(_photoEvidence.length * 120);

      }
      update();
    }
  }

  void removePhotoEvidence(int index) {
    _photoEvidence.removeAt(index);
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    if(otp != '') {
      update();
    }
  }

  _hideCanceledOption(){
    if(Get.find<SplashController>().configModel.content?.serviceManCanCancelBooking == 0 || providerServicemanCanCancelBooking == 0){
      statusTypeList.remove('canceled');
    }
  }
}