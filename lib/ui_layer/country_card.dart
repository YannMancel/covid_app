import 'package:covid_app/data_layer/status.dart';
import 'package:flutter/material.dart';

/// A [StatelessWidget] subclass.
class CountryCard extends StatelessWidget {

  // FIELDS --------------------------------------------------------------------

  final String countryName;
  final Status generalStatus;
  final List<Status> timeline;

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
                      Text(countryName),
                      const SizedBox(height: 8.0),
                      _getGeneralStatus(),
                      const SizedBox(height: 8.0),
                      _getChart()
                    ]))));
  }

  // -- UI --

  Widget _getGeneralStatus() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getSpecificStatus('Cases', generalStatus.cases),
          _getSpecificStatus('Recovered', generalStatus.recovered),
          _getSpecificStatus('Deaths', generalStatus.deaths)
        ]);
  }

  Widget _getSpecificStatus(String dataName, int data) {
    return Column(
      children: [
        Text(dataName),
        Text('$data'),
      ]);
  }

  Widget _getChart() {
    return Container(height: 200.0, color: Colors.green);
    //     subtitle: Text('timeline length ${timeline.length}'));
  }
}
