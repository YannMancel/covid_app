import 'package:shared_preferences/shared_preferences.dart';

// METHODS ---------------------------------------------------------------------

/// Reads a [List] of [String] values from persistent storage,
/// if the key does not correspond to a String set, it will return null.
Future<List<String>> getStringListFromSharedPreferences(String key) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  try {
    return sharedPreferences.getStringList(key);
  } catch (e) {
    print('the key does not correspond to a String set.');
    return null;
  }
}

/// Saves a [List] of [String] values to persistent storage in the background.
/// If [values] is null, this is equivalent to calling remove() on the [key].
/// If the action correctly performs, it returns true otherwise false.
Future<bool> setStringListFromSharedPreferences(
  String key,
  List<String> values
) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return await sharedPreferences.setStringList(key, values);
}