import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen> {

  void _loadData(){
    Get.find<DashboardController>().getDashboardData();
    Get.find<DashboardController>().changeToYearlyEarnStatisticsChart(EarningType.monthly);
    Get.find<DashboardController>().getMonthlyBookingsDataForChart(
      DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString(),
      isRefresh: true
    );
    Get.find<DashboardController>().getYearlyBookingsDataForChart(
      DateConverter.stringYear(DateTime.now()),
      isRefresh: true
    );
    Get.find<NotificationController>().getNotifications(1,saveNotificationCount: false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.background,
      appBar:  MainAppBar(color: Theme.of(context).primaryColor,),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
        onRefresh: () async {
          _loadData();
        },
        child: SingleChildScrollView(
          child: GetBuilder<DashboardController>(
            builder: (dashboardController){
              return dashboardController.isLoading ?
              const DashboardTopCardShimmer() :

              const Column(
                children:[
                  BusinessSummerySection(),
                  BookingStatisticsSection(),
                  RecentActivitySection(),
                  SizedBox(height: Dimensions.paddingSizeDefault,)
                ],
              );
            },
          ),
        ),
      )
    );
  }
}
