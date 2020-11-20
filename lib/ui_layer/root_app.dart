import 'package:covid_app/bloc_layer/covid_data_bloc.dart';
import 'package:covid_app/bloc_layer/storage_bloc.dart';
import 'package:covid_app/ui_layer/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A [StatelessWidget] subclass.
class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MultiProvider(
          providers: [
            Provider<CovidDataBLoC>(
              create: (_) => CovidDataBLoC(),
              dispose: (_, CovidDataBLoC bloc) => bloc.dispose(),
              lazy: false),
            Provider<StorageBLoC>(
                create: (_) => StorageBLoC(),
                dispose: (_, StorageBLoC bloc) => bloc.dispose(),
                lazy: false)
          ],
          child: HomePage(title: 'COVID-19')
      ));
  }
}