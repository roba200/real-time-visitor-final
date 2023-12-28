import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:visitor_counting_system/Bar_Graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List monthlySummary;
  const MyBarGraph({super.key, required this.monthlySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        januaryData: monthlySummary[0],
        februaryData: monthlySummary[1],
        marchData: monthlySummary[2],
        aprilData: monthlySummary[3],
        mayData: monthlySummary[4],
        juneData: monthlySummary[5],
        julyData: monthlySummary[6],
        augustData: monthlySummary[7],
        septemberData: monthlySummary[8],
        octoberData: monthlySummary[9],
        novemberData: monthlySummary[10],
        decemberData: monthlySummary[11]);

    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 1000,
        minY: 0,
        titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitles))),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      borderRadius: BorderRadius.circular(4),
                      width: 15,
                      toY: data.y)
                ]))
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10);

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = Text(
        'JAN',
        style: style,
      );
      break;

    case 2:
      text = Text(
        'FEB',
        style: style,
      );
      break;

    case 3:
      text = Text(
        'MAR',
        style: style,
      );
      break;

    case 4:
      text = Text(
        'APR',
        style: style,
      );
      break;
    case 5:
      text = Text(
        'MAY',
        style: style,
      );
      break;
    case 6:
      text = Text(
        'JUN',
        style: style,
      );
      break;

    case 7:
      text = Text(
        'JUL',
        style: style,
      );
      break;
    case 8:
      text = Text(
        'AUG',
        style: style,
      );
      break;
    case 9:
      text = Text(
        'SEP',
        style: style,
      );
      break;
    case 10:
      text = Text(
        'OCT',
        style: style,
      );
      break;
    case 11:
      text = Text(
        'NOV',
        style: style,
      );
      break;
    case 12:
      text = Text(
        'DEC',
        style: style,
      );
      break;
    default:
      text = Text(
        '',
        style: style,
      );
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
