import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:idsr/utils/app_colors.dart';

class LineChartSample5 extends StatefulWidget {
  const LineChartSample5({
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
  })  : gradientColor1 = gradientColor1 ?? AppColors.contentColorBlue,
        gradientColor2 = gradientColor2 ?? AppColors.contentColorPink,
        gradientColor3 = gradientColor3 ?? AppColors.contentColorRed,
        indicatorStrokeColor = indicatorStrokeColor ?? AppColors.mainTextColor1;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  @override
  State<LineChartSample5> createState() => _LineChartSample5State();
}

class _LineChartSample5State extends State<LineChartSample5> {
  List<int> showingTooltipOnSpots = [1, 3, 5];

  List<FlSpot> get allSpots => const [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 5),
    FlSpot(6, 8),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.contentColorPink,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );
    String text = switch (value.toInt()) {
      0 => '00:00',
      1 => '04:00',
      2 => '08:00',
      3 => '12:00',
      4 => '16:00',
      5 => '20:00',
      6 => '23:59',
      _ => '',
    };
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,

        ),
        dotData: const FlDotData(show: false),

      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 1.0,
          vertical: 1,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(


              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles:  const AxisTitles(
                  axisNameWidget: Text(''),
              sideTitles: SideTitles(
                showTitles: false,
                reservedSize: 0,
              ),
            ),
                rightTitles: const AxisTitles(
                  axisNameWidget: Text(''),
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 30,
                  ),
                ),


              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: AppColors.borderColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

