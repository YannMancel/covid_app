import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Container()));
  }
}
