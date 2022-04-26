import 'package:goldenmovie/database/fav_db.dart';
import 'package:goldenmovie/data_source/favDs.dart';
import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';

class FavRepo {
  final _favLocalDs = FavDs();

  // final _mapper = FavItemMapper();
  final cartDb = CartDataBase.instance;

  /// from shared preferences

  Stream<bool> addTofav(List<MovieDetailItem> favItemList) {
    return _favLocalDs.setCart(favItemList);
  }


  Stream<FavItemList> getFav() {
    return _favLocalDs.getFav().map((event) {
      return event..movie;
    });
  }





/// From Database

// Stream<int?> addTofav(MovieDetailItem favItemList) {
//   return Stream.fromFuture(cartDb.insertFavItems(favItemList));
//
// }
//
// Stream<FavItemList> getFav() {
//   return Stream.fromFuture(cartDb.getFavItems());
//

// }
}
