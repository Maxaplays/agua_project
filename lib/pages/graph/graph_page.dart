import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});
  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final List<double> weeklyData = [100, 150, 120, 110, 90, 140, 130];
  final List<String> weeklyDataDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thrusday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: weeklyData.reduce(
                (first, second) => first > second ? first : second,
              ),
              barTouchData: BarTouchData(enabled: true),

              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      return Text(
                        weeklyDataDays[index].substring(0, 3),
                        style: TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 50,
                    showTitles: true,
                    getTitlesWidget: (value, meta) =>
                        Text("${value.toInt()} L"),
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),

              barGroups: List.generate(weeklyData.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: weeklyData[index],
                      width: 20,
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
