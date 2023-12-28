import 'package:visitor_counting_system/Bar_Graph/individual_bar.dart';

class BarData {
  final int januaryData;
  final int februaryData;
  final int marchData;
  final int aprilData;
  final int mayData;
  final int juneData;
  final int julyData;
  final int augustData;
  final int septemberData;
  final int octoberData;
  final int novemberData;
  final int decemberData;

  BarData(
      {required this.januaryData,
      required this.februaryData,
      required this.marchData,
      required this.aprilData,
      required this.mayData,
      required this.juneData,
      required this.julyData,
      required this.augustData,
      required this.septemberData,
      required this.octoberData,
      required this.novemberData,
      required this.decemberData});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 1, y: januaryData.toDouble()),
      IndividualBar(x: 2, y: februaryData.toDouble()),
      IndividualBar(x: 3, y: marchData.toDouble()),
      IndividualBar(x: 4, y: aprilData.toDouble()),
      IndividualBar(x: 5, y: mayData.toDouble()),
      IndividualBar(x: 6, y: juneData.toDouble()),
      IndividualBar(x: 7, y: julyData.toDouble()),
      IndividualBar(x: 8, y: augustData.toDouble()),
      IndividualBar(x: 9, y: septemberData.toDouble()),
      IndividualBar(x: 10, y: octoberData.toDouble()),
      IndividualBar(x: 11, y: novemberData.toDouble()),
      IndividualBar(x: 12, y: decemberData.toDouble()),
    ];
  }
}
