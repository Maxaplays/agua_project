import 'package:agua_project/theme/colors.dart';
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: weeklyData.reduce(
                      (first, second) => first > second ? first : second,
                    ),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        direction: TooltipDirection.bottom,
                      ),
                    ),
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: 120,
                          color: Colors.red,
                          strokeWidth: 2,
                          dashArray: [8, 4],
                        ),
                      ],
                    ),

                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            return Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                weeklyDataDays[index].substring(0, 3),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 40,
                          showTitles: true,
                          interval: 40,
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
                      final value = weeklyData[index];
                      final isabove = value > 120;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: value,
                            width: 20,
                            borderRadius: BorderRadius.circular(6),
                            color: isabove ? Colors.red : AppColors.primaryMain,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                "Congrats! You’re using water wisely and giving the planet a little breather. Keep it up!",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Column(
              children: List.generate(weeklyDataDays.length, (index) {
                final listObj = weeklyDataDays[index];
                final data = weeklyData[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 50,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listObj,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          data.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
