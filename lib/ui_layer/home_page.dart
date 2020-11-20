import 'package:covid_app/bloc_layer/covid_data_bloc.dart';
import 'package:covid_app/bloc_layer/storage_bloc.dart';
import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/ui_layer/countries_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A [StatefulWidget] subclass.
class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

/// A [State] of [HomePage] subclass.
class _HomePageState extends State<HomePage> {

  // METHODS -------------------------------------------------------------------

  // -- State --

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      drawer: _getDrawer(),
      body: SingleChildScrollView(
        child: Container()));
  }

  // -- UI --

  Widget _getDrawer() {
    return Drawer(
        child: Container(
            child: Column(children: [
                Container(width: double.infinity, child: _getDrawerHeader()),
                Expanded(child: _getCountriesFromSharedPreferences())
            ])));
  }

  Widget _getDrawerHeader() {
    return DrawerHeader(
        decoration: const BoxDecoration(gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent])),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                _getCountryNumber(),
                ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _showAddDialog,
                    label: const Text('Countries', style: const TextStyle(
                        color: Colors.white, fontSize: 20.0)))
            ]));
  }

  Widget _getCountryNumber() {
    return Consumer<CovidDataBLoC>(builder: (_, bloc, __) =>
        StreamBuilder<List<Country>>(
            stream: bloc.countriesStream,
            initialData: bloc.countries,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    '${snapshot.data.length} available countries',
                    style: const TextStyle(color: Colors.white, fontSize: 20.0));
              }
              return const Text('No country');
            })
    );
  }

  Widget _getCountriesFromSharedPreferences() {
    return Consumer<StorageBLoC>(builder: (_, bloc, __) =>
        StreamBuilder<List<String>>(
            stream: bloc.countryNamesStream,
            initialData: bloc.countryName,
            builder: (_, snapshot) {
              return ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: (snapshot.hasData)
                      ? snapshot.data.length
                      : 0,
                  itemBuilder: (_, index) =>
                      ListTile(
                          title: Text(snapshot.data[index]),
                          trailing: const Icon(Icons.delete),
                          onTap: () {
                            _removeCountryInStorage(snapshot.data[index]);
                            Navigator.pop(context);
                          }));
            })
    );
  }

  // -- Dialog --

  Future<void> _showAddDialog() async {
    return showDialog<void>(
        context: context,
        builder: (_) => CountriesDialog(
            countries: Provider.of<CovidDataBLoC>(context).countries,
            actionOnClick: _addCountriesInStorage));
  }

  // -- Storage --

  Future<void> _addCountriesInStorage(List<Country> countries) async {
    final newCountryNames = countries
        .map((country) => country.name)
        .toList();

    Provider.of<StorageBLoC>(context, listen: false)
        .addCountryNames(newCountryNames);
  }

  Future<void> _removeCountryInStorage(String countryName) async {
    Provider.of<StorageBLoC>(context, listen: false)
        .removeCountryName(countryName);
  }
}