import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class YearlyDashBoardChart extends StatefulWidget {
  const YearlyDashBoardChart({Key? key}) : super(key: key);

  @override
  YearlyDashBoardChartState createState() => YearlyDashBoardChartState();
}

class YearlyDashBoardChartState extends State<YearlyDashBoardChart> {
  List<Color> gradientColors = [
    const Color(0xfffc8e91),
    const Color(0xff4560ad),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder:(dashboardController){
      return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: ResponsiveHelper.isTab(context)? 5 :1.8,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 8.0, bottom: 8),
            child: LineChart(
              mainData(dashboardController),
            ))),
      ],
    );
  });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jun', style: style);
        break;
      case 7:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Aug', style: style);
        break;
      case 9:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Oct', style: style);
        break;
      case 11:
        text = const Text('Nov', style: style);
        break;
      case 12:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  LineChartData mainData(DashboardController controller) {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          fitInsideHorizontally: true,
        ),
      ),
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            )
            ,
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
              axisNameSize: 20,
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: controller.mmY<100.00?40:controller.mmY<10000?45:controller.mmY<100000?50:55,
              )

          )

      )
      ,
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 1),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),

      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: controller.mmY,
      lineBarsData: [
        LineChartBarData(
          spots: controller.yearlyChartList,
          isCurved: false,
          curveSmoothness: 0,

          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.4))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
