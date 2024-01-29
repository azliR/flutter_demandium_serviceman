import 'package:get/get.dart';
import 'package:demandium_serviceman/feature/dashboard/widgets/yearly_dashboad_chart.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_button.dart';
import 'monthly_dashboard_chart.dart';

class BookingStatisticsSection extends GetView<DashboardController> {
  const BookingStatisticsSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> previousYearsList =[];
    for(int i=4;i>=0;i--){
      previousYearsList.add((DateTime.now().year -i).toString());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault+3, vertical: Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              Image.asset(Images.dashboardEarning,height: 15,width: 15,),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Text(
                "booking_statistics".tr,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              right: Dimensions.paddingSizeSmall,
              top:Dimensions.paddingSizeDefault,
              bottom: Dimensions.paddingSizeSmall
          ),
          decoration: BoxDecoration(
              color:Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),              boxShadow: shadow
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<DashboardController>(
                builder: (dashboardController){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      GestureDetector(
                        onTap: (){
                          dashboardController.changeToYearlyEarnStatisticsChart(EarningType.monthly);
                          Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter
                              .stringYear(DateTime.now()),DateTime.now().month.toString()
                          );
                        },
                        child:  DashboardCustomButton(
                            buttonText: "monthly".tr,
                            isSelectedButton: dashboardController.getChartType == EarningType.monthly ? true: false
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      GestureDetector(
                        onTap: (){
                          dashboardController.changeToYearlyEarnStatisticsChart(EarningType.yearly);
                          dashboardController.changeDashboardDropdownValue(DateConverter.stringYear(DateTime.now()),"Year");
                        },
                        child:  DashboardCustomButton(
                            buttonText: "yearly".tr,
                            isSelectedButton: dashboardController.getChartType == EarningType.yearly ? true: false
                        ),
                      ),
                    ],
                  );
                },

              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              GetBuilder<DashboardController>(
                  builder:(dashboardController){
                    return dashboardController.getChartType == EarningType.monthly ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        CustomDropDownButton(type: "Year",itemList: previousYearsList ,title:"year".tr),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        CustomDropDownButton(
                            type: "Month",
                            itemList: const ['January','February','March','April','May','June','July','August',
                              'September','October','November','December'],
                            title:"month".tr
                        ),
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomDropDownButton(type: "Year",itemList: previousYearsList ,title:"year".tr),
                      ],
                    );
                  }),

              GetBuilder<DashboardController>(
                builder: (controller){
                return SizedBox(
                  width: context.width,
                  child: controller.getChartType == EarningType.monthly ?
                  const MonthlyDashBoardChart():
                  const YearlyDashBoardChart(),
                );
              }),
              Text("total_bookings".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),),
            ],
          ),
        ),
      ],
    );
  }
}
