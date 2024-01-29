import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:demandium_serviceman/feature/dashboard/model/dashboard_model.dart';


enum EarningType{monthly, yearly}
class  DashboardController extends GetxController implements GetxService{
  final DashboardRepository dashboardRepository;
  DashboardController({required this.dashboardRepository});

  EarningType  _showMonthlyEarnStatisticsChart = EarningType.monthly;
  EarningType get getChartType => _showMonthlyEarnStatisticsChart;

  TopCards _topCards= TopCards();
  get cards => _topCards;

  List<DashboardBooking> _booking = [];
  List<DashboardBooking> get bookings => _booking;

  bool _isLoading=false;
  get isLoading=> _isLoading;

  bool _isLeapYear=false;
  get isLeapYear=> _isLeapYear;


  //Monthly Stats
  List<MonthlyStats> _monthlyStatsList =[];
  List<double> _mStatsList = [];
  List<FlSpot> _monthlyChartList = [];
  List<FlSpot> get monthlyChartList =>_monthlyChartList;

  double _mmM =0;
  double get mmM => _mmM;

  String _selectedYear = DateConverter.stringYear(DateTime.now());
  String get selectedYear => _selectedYear;
  String _selectedMonth = '';
  String get selectedMonth => _selectedMonth;

  //yearly Stats
  List<YearlyStats> _yearlyStatsList =[];
  List<double> _yStatsList = [];
  List<FlSpot> _yearlyChartList = [];
  List<FlSpot> get yearlyChartList =>_yearlyChartList;

  double _mmY =0;
  double get mmY => _mmY;
  List<dynamic>? _bookings;



  @override
  void onInit(){
    super.onInit();
    getMonthlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
    getYearlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()));
  }

  Future<void> getDashboardData()async{
    _isLoading=true;
    _bookings=[];
    _booking=[];
    update();
    Response response = await dashboardRepository.getDashboardData();

    if(response.statusCode == 200){
      _topCards = TopCards.fromJson(response.body['content'][0]['top_cards']);
      _bookings= response.body['content'][1]['bookings'];
      for (var serviceman in _bookings!) {
        _booking.add(DashboardBooking.fromJson(serviceman));
      }
      update();
    } else{
      ApiChecker.checkApi(response);
    }
    _isLoading=false;
    update();
  }

  Future<void> getMonthlyBookingsDataForChart(String year,String month,{bool isRefresh=false}) async {
    if(isRefresh){
      _selectedYear = DateConverter.stringYear(DateTime.now());
    }
    _monthlyStatsList = [];
    Response response = await dashboardRepository.getMonthlyChartData(year,month);
    if(response.statusCode == 200) {
      _monthlyStatsList = [];
      _mStatsList = [];
      _monthlyChartList = [];
      List<dynamic> monthlyDynamicList= response.body['content'][0]['booking_stats'];
      for (var element in monthlyDynamicList) {
        _monthlyStatsList.add(MonthlyStats.fromJson(element));
      }


      if(month == '2'){
        int lip=0;
        bool isLeapYear(yer) => (yer % 4 == 0) && ((yer % 100 != 0) || (yer % 400 == 0));
        bool leapYear = isLeapYear(int.tryParse(year));
        if(leapYear == true){
          _isLeapYear=true;
          lip=30;
          update();
        }else {
          lip=29;
        }
        for(int i = 0; i<lip; i++){
          _mStatsList.add(0);
        }
      }else if(month == '4' || month == '6' || month == '9' || month == '11'){
        for(int i = 0; i<31; i++){
          _mStatsList.add(0);
        }
      }else if(month == '1' || month == '3' || month == '5' || month == '7' || month == '8' || month == '10' || month == '12'){
        for(int i = 0; i<32; i++){
          _mStatsList.add(0);
      }
      }

      for(int i = 0; i< _monthlyStatsList.length; i++){
        _mStatsList[_monthlyStatsList[i].day!] = _monthlyStatsList[i].total!.toDouble();
      }

      _monthlyChartList = _mStatsList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();
      _mStatsList.sort();

      _mmM = _mStatsList[_mStatsList.length-1];
      _isLoading = false;
      update();

    }else {
     // ApiChecker.checkApi(response);
    }
    if(response.body["response_code"] != "default_200"){
      showCustomSnackBar(response.body["errors"][0]["message"], isError:true);
    }
    update();
  }



  Future<void> getYearlyBookingsDataForChart(String year,{bool isRefresh=false}) async {
    if(isRefresh){
      _selectedYear = DateConverter.stringYear(DateTime.now());
    }
    _yearlyStatsList = [];
    Response response = await dashboardRepository.getYearlyChartData(year);
    if(response.statusCode == 200) {
      _yearlyStatsList = [];
      _yStatsList = [];
      _yearlyChartList = [];
      List<dynamic> yearlyDynamicList= response.body['content'][0]['booking_stats'];
      for (var element in yearlyDynamicList) {
        _yearlyStatsList.add(YearlyStats.fromJson(element));
      }
      for(int i =0; i<13; i++){
        _yStatsList.add(0);
      }
      for(int i = 0; i< _yearlyStatsList.length; i++){
       _yStatsList[_yearlyStatsList[i].month!] = _yearlyStatsList[i].total!.toDouble();
      }
      _yearlyChartList = _yStatsList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();
      _yStatsList.sort();
      _mmY = _yStatsList[_yStatsList.length-1];
      _isLoading = false;
      update();
    }else {
      //ApiChecker.checkApi(response);
    }
    if(response.body["response_code"] != "default_200"){
      showCustomSnackBar(response.body["errors"][0]["message"], isError:true);
    }
    update();
  }

  void changeDashboardDropdownValue(String value,String type){
    if(type=="Year"){
      _selectedYear=value;
      if(_selectedYear !="Select" && _showMonthlyEarnStatisticsChart == EarningType.yearly){
        getYearlyBookingsDataForChart(_selectedYear);
      }
      update();
    }else if(type=="Month"){
      _selectedMonth=value;
      if(_selectedYear !="Select"){
        getMonthlyBookingsDataForChart(_selectedYear,value);
      }
      update();
    }
  }

  void changeToYearlyEarnStatisticsChart(EarningType selectedType){
    _showMonthlyEarnStatisticsChart = selectedType;
    _selectedYear = DateConverter.stringYear(DateTime.now());
    update();
  }

}












