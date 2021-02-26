import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  BarChart(this.seriesList, this.animate);

  factory BarChart.withSampleData() {
    return new BarChart(
      _createSampleData(),
      false,
    );
  }

  static List<charts.Series<DayData, String>> _createSampleData() {
    final caloriesGained = [
      new DayData('Sun', 2300),
      new DayData('Mon', 2000),
      new DayData('Tue', 2000),
      new DayData('Wed', 2500),
      new DayData('Thu', 1900),
      new DayData('Fri', 1800),
      new DayData('Sat', 2500)
    ];
    final caloriesBurned = [
      new DayData('Sun', 1000),
      new DayData('Mon', 1320),
      new DayData('Tue', 900),
      new DayData('Wed', 1500),
      new DayData('Thu', 1250),
      new DayData('Fri', 1000),
      new DayData('Sat', 700)
    ];
    return [
      new charts.Series<DayData, String>(
        id: 'Calories Gained',
        domainFn: (DayData data, _) => data.day,
        measureFn: (DayData data, _) => data.calories,
        data: caloriesGained,
      ),
      new charts.Series<DayData, String>(
        id: 'Calories Burned',
        domainFn: (DayData data, _) => data.day,
        measureFn: (DayData data, _) => data.calories,
        data: caloriesBurned,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.PanAndZoomBehavior()]
    );
  }
}

class DayData {
  final String day;
  final int calories;

  DayData(this.day, this.calories);
}
