// ignore_for_file: deprecated_member_use

import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';




class HomeScreen extends StatefulWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  void _loadData() {
    Get.find<DashboardController>().getDashboardData();
    Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
    Get.find<DashboardController>().getYearlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()));
    Get.find<BookingListController>().updateBookingStatusState(BooingListStatus.accepted);
    Get.find<BookingHistoryController>().getBookingHistory('all',1);
    Get.find<BookingHistoryController>().updateIndex(0);
  }


  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _loadData();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const DashBoardScreen(),
      const BookingListScreen(),
      const BookingHistoryScreen(),
      const Text("More"),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if(_canExit) {
            return true;
          }else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr, style: const TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: ResponsiveHelper.isDesktop(context) ? const SizedBox() : SafeArea(
          child: Container(
            height: 30 + MediaQuery.of(context).padding.top, alignment: Alignment.center,
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
                color: Get.isDarkMode?Theme.of(context).colorScheme.background:Theme.of(context).primaryColor,
                boxShadow:[
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 10,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  )]
            ),
            child: Row(children: [
              _getBottomNavItem(0, Images.dashboard, 'dashboard'.tr),
              _getBottomNavItem(1, Images.requests, 'requests'.tr),
              _getBottomNavItem(2, Images.history, 'history'.tr),
              _getBottomNavItem(3, Images.moree, 'more'.tr),
            ]),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    if(pageIndex == 3) {
      Get.bottomSheet(const MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
    }else {
      setState(() {
        _pageController!.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
      });
    }
  }

  Widget _getBottomNavItem(int index, String icon, String title) {
    return Expanded(child: InkWell(
      onTap: () => _setPage(index),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        icon.isEmpty ? const SizedBox(width: 20, height: 20) : Image.asset(
          icon, width: 18, height: 18,
            color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Text(title, style: ubuntuRegular.copyWith(
          fontSize: Dimensions.fontSizeSmall,
            color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        )),

      ]),
    ));
  }

}
