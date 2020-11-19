import 'package:covid_app/data_layer/country.dart';
import 'package:flutter/material.dart';

typedef Action = void Function(List<Country> countries);

/// A [StatelessWidget] subclass.
class CountriesDialog extends StatelessWidget {

  // FIELDS --------------------------------------------------------------------

  final List<Country> countries;
  final Action actionOnClick;

  // CONSTRUCTORS --------------------------------------------------------------

  CountriesDialog({@required this.countries, @required this.actionOnClick});

  // METHODS -------------------------------------------------------------------

  // -- StatelessWidget --

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text('Countries', textAlign: TextAlign.center),
        contentPadding: EdgeInsets.all(16.0),
        children: [
          // TextField(
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(labelText: (widget.mode == Mode.INSERT)
          //         ? 'New category' : widget.oldCategory.title),
          //     onChanged: (name) => _newTitle = name),
          SizedBox(height: 16.0),
          _getListViewForCountries(),
          SizedBox(height: 16.0),
          ElevatedButton(
              child: Text('Add countries'),
              onPressed: null)
        ]);
  }

  // -- UI --

  Widget _getListViewForCountries() {
    return Container(
        width: 350.0,
        height: 250,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: countries.length,
            itemBuilder: (_, index) =>
              ListTile(
                  title: Text(countries[index].name),
                  leading: Icon(Icons.close))));
  }
}