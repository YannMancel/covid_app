import 'package:covid_app/data_layer/country.dart';
import 'package:flutter/material.dart';

typedef Action = void Function(List<Country> countries);

/// A [StatefulWidget] subclass.
class CountriesDialog extends StatefulWidget {
  final List<Country> countries;
  final Action actionOnClick;

  CountriesDialog({@required this.countries, @required this.actionOnClick});

  @override
  _CountriesDialogState createState() => _CountriesDialogState();
}

/// A [State] of [CountriesDialog] subclass.
class _CountriesDialogState extends State<CountriesDialog> {

  // FIELDS --------------------------------------------------------------------

  List<Map<Country, bool>> _countries;
  List<Map<Country, bool>> _filteredCountries;

  // METHODS -------------------------------------------------------------------

  // -- State --

  @override
  void initState() {
    super.initState();
    _configureCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text('Countries', textAlign: TextAlign.center),
        contentPadding: const EdgeInsets.all(16.0),
        children: [
          TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Search country'),
              onChanged: _updateFilteredCountries),
          const SizedBox(height: 16.0),
          _getListViewForCountries(),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context))),
              const SizedBox(width: 16.0),
              Expanded(child: ElevatedButton(
                  child: const Text('Add'),
                  onPressed: _onClickButton))
            ])
        ]);
  }

  // -- UI --

  Widget _getListViewForCountries() {
    if (_filteredCountries.isEmpty)
      return const Text('No result', textAlign: TextAlign.center);

    return Container(
        width: double.infinity,
        height: 250.0,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _filteredCountries.length,
            itemBuilder: (_, index) {
              final Map<Country, bool> country = _filteredCountries[index];
              return SwitchListTile(
                  title: Text('${country.keys.first.name}'),
                  value: country.values.first,
                  onChanged: (isSelected) =>
                      _actionToSwitchCountry(index, isSelected));
            }));
  }

  // -- Filter --

  void _updateFilteredCountries(String search) {
    setState(() {
      if (search.isNotEmpty) {
        final newCountries = _countries
          .where((country) =>
            country.keys.first.name.toLowerCase().contains(search.toLowerCase()))
          .toList();

        _filteredCountries = newCountries;
      } else {
        _filteredCountries = _countries;
      }
    });
  }

  // -- Country --

  void _configureCountryData() {
    _countries = widget.countries
        .map((country) => {country: false})
        .toList();
    _filteredCountries = _countries;
  }

  void _actionToSwitchCountry(int index, bool isSelected) {
    setState(() {
      final country = _filteredCountries[index].keys.first;
      _filteredCountries[index][country] = isSelected;
    });
  }

  // -- Action --

  void _onClickButton() {
    if (widget.actionOnClick != null) {
      final selectedCountries = _countries
          .where((country) => country.values.first)
          .map((map) => map.keys.first)
          .toList();

      widget.actionOnClick(selectedCountries);
    }
    Navigator.pop(context);
  }
}