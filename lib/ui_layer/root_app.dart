import 'package:covid_app/bloc_layer/app_bloc.dart';
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
      home: Provider<AppBLoc>(
          create: (_) => AppBLoc(),
          dispose: (_, AppBLoc bloc) => bloc.dispose(),
          lazy: false,
          child: HomePage(title: 'COVID-19')));
  }
}