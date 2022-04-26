import 'dart:convert';

import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/response/movie_detail_res.dart';
import 'package:rxdart/src/transformers/flat_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavDs {
  SharedPreferenceManager _preferenceManager = SharedPreferenceManager();

  /// getting value from shared preferences

  Stream<FavItemList> getFav() {
    return _preferenceManager.getStringList("fav").map((event) {
      return FavItemList(
          movie: event
              ?.map((e) => MovieDetailItem.fromJson(jsonDecode(e)))
              .toList());
    });
  }

  ///set value in shared preferences

  Stream<bool> setCart(List<MovieDetailItem> favItemList) {
    return _preferenceManager.setStringList(
        "fav", favItemList.map((e) => jsonEncode(e.toJson())).toList());
  }

}


class SharedPreferenceManager {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  static const _DEBUG = true;

  Stream<SharedPreferences> _getSharedPreference() {
    return _convertToRx(_sharedPreferences);
  }

  Stream<List<String>?> getStringList(String key) {
    if (_DEBUG) print('Reading key: $key value: $key');
    return _getSharedPreference()
        .map((preference) => preference.getStringList(key));
  }

  Stream<bool> setStringList(String key, List<String> value) {
    if (_DEBUG) print('Writing key: $key value: $value');
    return _getSharedPreference().flatMap(
        (preference) => _convertToRx(preference.setStringList(key, value)));
  }




  Stream<T> _convertToRx<T>(Future<T> future) {
    return Stream.fromFuture(future);
  }
}
