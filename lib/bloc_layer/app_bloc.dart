import 'dart:async';
import 'package:covid_app/bloc_layer/covid_data_bloc.dart';
import 'package:covid_app/bloc_layer/storage_bloc.dart';
import 'base_bloc.dart';

/// A [BLoC] subclass.
class AppBLoc extends BLoC {

  // FIELDS --------------------------------------------------------------------

  StorageBLoC _storageBLoC;
  StorageBLoC get storageBLoC => _storageBLoC;

  CovidDataBLoC _covidDataBLoC;
  CovidDataBLoC get covidDataBLoC => _covidDataBLoC;

  StreamSubscription<List<String>> _streamBetweenStorageAndCovidData;

  // CONSTRUCTORS --------------------------------------------------------------

  AppBLoc() {
    _storageBLoC = StorageBLoC();
    _covidDataBLoC = CovidDataBLoC();

    _streamBetweenStorageAndCovidData =
        _storageBLoC.countryNamesStream.listen((event) =>
            _covidDataBLoC.getStatusOfSelectedCountries(event));
  }

  // METHODS -------------------------------------------------------------------

  // -- BLoC --

  @override
  void dispose() async {
    await _streamBetweenStorageAndCovidData.cancel();
    _storageBLoC.dispose();
    _covidDataBLoC.dispose();
  }
}