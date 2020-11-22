import 'package:covid_app/ui_layer/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Just in Portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(RootApp());
}