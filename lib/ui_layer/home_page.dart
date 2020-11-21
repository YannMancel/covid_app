import 'package:covid_app/bloc_layer/app_bloc.dart';
import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/status.dart';
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
    return Consumer<AppBLoc>(builder: (_, bloc, __) =>
        Scaffold(
          appBar: AppBar(title: Text(widget.title), centerTitle: true),
          drawer: _getDrawer(bloc),
          body: Center(child:
              StreamBuilder<List<Status>>(
                stream: bloc.covidDataBLoC.statusStream,
                builder: (_, snapshot) =>
                (snapshot.hasData)
                    ? Text(snapshot.data.length.toString())
                    : const Text("No data")))));
  }

  // -- UI --

  Widget _getDrawer(AppBLoc bloc) {
    return Drawer(
        child: Container(
            child: Column(children: [
                Container(width: double.infinity, child: _getDrawerHeader(bloc)),
                Expanded(child: _getCountriesFromStorage(bloc))
            ])));
  }

  Widget _getDrawerHeader(AppBLoc bloc) {
    return DrawerHeader(
        decoration: const BoxDecoration(gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent])),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                _getCountryNumber(bloc),
                ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _showAddDialog,
                    label: const Text('Countries', style: const TextStyle(
                        color: Colors.white, fontSize: 20.0)))
            ]));
  }

  Widget _getCountryNumber(AppBLoc bloc) {
    return StreamBuilder<List<Country>>(
        stream: bloc.covidDataBLoC.countriesStream,
        builder: (_, snapshot) =>
          (snapshot.hasData)
              ? Text('${snapshot.data.length} available countries',
                  style: const TextStyle(color: Colors.white, fontSize: 20.0))
              : const Text('No country'));
  }

  Widget _getCountriesFromStorage(AppBLoc bloc) {
    return StreamBuilder<List<String>>(
        stream: bloc.storageBLoC.countryNamesStream,
        builder: (_, snapshot) =>
            ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (_, __) => const Divider(),
                itemCount: (snapshot.hasData)
                    ? snapshot.data.length : 0,
                itemBuilder: (_, index) =>
                    ListTile(
                        title: Text(snapshot.data[index]),
                        trailing: const Icon(Icons.delete),
                        onTap: () {
                          _removeCountryInStorage(snapshot.data[index]);
                          Navigator.pop(context);
                        })));
  }

  // -- Dialog --

  Future<void> _showAddDialog() async {
    final countries = Provider.of<AppBLoc>(context, listen: false)
        .covidDataBLoC
        .countries;

    return showDialog<void>(
        context: context,
        builder: (_) => CountriesDialog(
            countries: countries,
            actionOnClick: _addCountriesInStorage));
  }

  // -- Storage --

  Future<void> _addCountriesInStorage(List<Country> countries) async {
    final newCountryNames = countries
        .map((country) => '${country.name} (${country.alpha2})')
        .toList();

    Provider.of<AppBLoc>(context, listen: false)
        .storageBLoC
        .addCountryNames(newCountryNames);
  }

  Future<void> _removeCountryInStorage(String countryName) async {
    Provider.of<AppBLoc>(context, listen: false)
        .storageBLoC
        .removeCountryName(countryName);
  }
}