import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:idsr/data/idsr/models/threshold_model.dart';

class DiseaseTrendChart extends StatefulWidget {
  final ThresholdModel data;

  const DiseaseTrendChart({
    super.key,
    required this.data,
  });

  @override
  State<DiseaseTrendChart> createState() => _DiseaseTrendChartState();
}

class _DiseaseTrendChartState extends State<DiseaseTrendChart> {
  List<_ChartData> chartData = [];
  late ThresholdModel data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => chartData = []);

    try {


      final meta = data.metaData;
      final List dx = meta['dimensions']['dx'];
      final List cpe = meta['dimensions']['pe'];
      final Map items = meta['items'];
      final List rows = data.rows;

      List<_ChartData> realData = [];

      for (var del in dx) {
        final currentData = rows.where((d) => d[0] == del).toList();
        List<double> values = [];

        for (var peUnit in cpe) {
          final cd = currentData.firstWhere(
                  (r) => r[2] == peUnit,
              orElse: () => null);
          values.add(cd != null
              ? double.tryParse(cd[3].toString()) ?? 0
              : 0);
        }

        final totalValue = values.fold(0.0, (p, e) => p + e);

        realData.add(_ChartData(
          name: items[del]['name'].toString().split("|").last,
          value: totalValue,
        ));
      }

      // Sort ascending
      realData.sort((a, b) => a.value.compareTo(b.value));

      setState(() => chartData = realData);
    } catch (e) {
      debugPrint("Error fetching chart data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return SizedBox(
        height: 300,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final maxValue = chartData.map((e) => e.value).reduce((a, b) => a > b ? a : b) * 1.2;

    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            maxY: maxValue,
            alignment: BarChartAlignment.spaceBetween,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (val, meta) {
                    final index = val.toInt();
                    if (index < 0 || index >= chartData.length) return const SizedBox();
                    return Text(
                      chartData[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  },
                  reservedSize: 140,
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: (maxValue / 5).clamp(1, double.infinity), // prevent zero
                    getTitlesWidget: (val, meta) {
                      return Text(val.toInt().toString());
                    },
                  ),
                ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: chartData
                .asMap()
                .entries
                .map(
                  (entry) => BarChartGroupData(
                x: entry.key,
                barsSpace: 8,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    toY: entry.value.value,
                    width: 18,
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                    rodStackItems: [],
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxValue,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  final String name;
  final double value;
  _ChartData({required this.name, required this.value});
}