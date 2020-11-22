import 'dart:math';
import 'package:covid_app/data_layer/status.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ENUMS -----------------------------------------------------------------------

enum CovidParameter { CASES, RECOVERED, DEATHS }

extension on CovidParameter {
  String toShortString() => this.toString().split('.').last.toLowerCase();

  // ignore: missing_return
  Color getColor() {
    switch (this) {
      case CovidParameter.CASES: return Colors.red;
      case CovidParameter.RECOVERED: return Colors.green;
      case CovidParameter.DEATHS: return Colors.black87;
    }
  }
}

// CLASSES ---------------------------------------------------------------------

/// A [StatelessWidget] subclass.
class CountryCard extends StatelessWidget {

  // FIELDS --------------------------------------------------------------------

  final String countryName;
  final Status generalStatus;
  final List<List<Point<int>>> timeline;

  // CONSTRUCTORS --------------------------------------------------------------

  CountryCard({
    Key key,
    @required this.countryName,
    @required this.generalStatus,
    @required this.timeline}) : super(key: key);

  // METHODS -------------------------------------------------------------------

  // -- StatelessWidget --

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
        child: Card(
            elevation: 6.0,
            clipBehavior: Clip.hardEdge,
            child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    children: [
                      _getCountryName(),
                      const Divider(),
                      _getGeneralStatus(),
                      const Divider(),
                      _getChart()
                    ]))));
  }

  // -- UI --

  Widget _getCountryName() {
    return Text(countryName, style: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold));
  }

  Widget _getGeneralStatus() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getSpecificStatus(CovidParameter.CASES, generalStatus.cases),
          _getSpecificStatus(CovidParameter.RECOVERED, generalStatus.recovered),
          _getSpecificStatus(CovidParameter.DEATHS, generalStatus.deaths)
        ]);
  }

  Widget _getSpecificStatus(CovidParameter parameter, int data) {
    return Column(
        children: [
          Text(parameter.toShortString()),
          Text('$data', style: TextStyle(color: parameter.getColor()))
        ]);
  }

  Widget _getChart() {
    return Container(
        height: 200.0,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                showTitles: true,
                margin: 10.0,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0: return 'J0';
                    case -1: return 'J-1';
                    case -2: return 'J-2';
                    case -3: return 'J-3';
                    case -4: return 'J-4';
                    case -5: return 'J-5';
                    case -6: return 'J-6';
                  }
                  return '';
                }
              ),
              topTitles: SideTitles(showTitles: false),
              leftTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false)),
            lineBarsData: _getLineBarsData())));
  }

  // -- Chart --

  List<LineChartBarData> _getLineBarsData() {
    return [
      _getLineBarData(CovidParameter.CASES, timeline[0]),
      _getLineBarData(CovidParameter.RECOVERED, timeline[1]),
      _getLineBarData(CovidParameter.DEATHS, timeline[2]),
    ];
  }

  LineChartBarData _getLineBarData(CovidParameter parameter, List<Point<int>> data) {
    return LineChartBarData(
        spots: data
            .map((point) =>
                FlSpot(point.x.toDouble(), point.y.toDouble()))
            .toList(),
        isCurved: true,
        barWidth: 2,
        colors: [ parameter.getColor() ],
        dotData: FlDotData(show: false));
  }
}
