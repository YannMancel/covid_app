import 'package:covid_app/bloc_layer/covid_data_bloc.dart';
import 'package:covid_app/data_layer/country.dart';
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
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getCountryNumber(),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: _showAddDialog,
                    label: const Text('Countries', style: TextStyle(
                      color: Colors.white, fontSize: 20.0)))
                ])),
          _getCountriesFromSharedPreferences()
        ]));
  }

  Widget _getCountryNumber() {
    return Consumer<CovidDataBLoC>(builder: (_, bloc, __) =>
        StreamBuilder<List<Country>>(
            stream: bloc.countriesStream,
            initialData: bloc.countries,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    '${snapshot.data.length} available countries',
                    style: TextStyle(color: Colors.white, fontSize: 20.0));
              }
              return const Text('No country');
            })
    );
  }

  // -- Dialog --

  Future<void> _showAddDialog() async {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (_) => CountriesDialog(
  //           countries: Provider.of<CovidDataBLoC>(context).countries.take(5).toList(),
  //           actionOnClick: null));
  }

  // -- Country --

  Widget _getCountriesFromSharedPreferences() {
      return Container(
          height: double.maxFinite,
          //child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, index) =>
                    ListTile(
                        title: Text('Test $index'),
                        trailing: Icon(Icons.close),
                        onTap: () => Navigator.pop(context))));
  }
}