import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/response/genre_res.dart';

class GenreMapper extends BaseMapper<ResGenreItem, GenreItemList> {
  @override
  GenreItemList map(ResGenreItem t) {
    return GenreItemList(genres: t.genres);
  }
}
