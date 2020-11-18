import 'package:covid_app/ui_layer/home_page.dart';
import 'package:flutter/material.dart';

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
      home: HomePage(title: 'COVID-19'));
  }
}