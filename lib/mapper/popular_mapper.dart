import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/popular_movie_item.dart';
import 'package:goldenmovie/response/popular_movie_response.dart';

class PopularMapper extends BaseMapper<ResPopularMovieItem, PopularMovieItem> {
  @override
  PopularMovieItem map(ResPopularMovieItem t) {
    return PopularMovieItem(
        totalPages: t.totalPages,
        results: t.results,
        totalResults: t.totalResults,
        page: t.page);
  }
}
