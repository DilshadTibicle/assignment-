import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/upcoming_movie_item.dart';
import 'package:goldenmovie/response/up_coming_response.dart';

class UpcomingMapper extends BaseMapper<ResUpcomingMovie, UpcomingMovieItem> {
  @override
  UpcomingMovieItem map(ResUpcomingMovie t) {
    return UpcomingMovieItem(
        totalPages: t.totalPages,
        results: t.results,
        page: t.page,
        totalResults: t.totalResults,
        dates: t.dates);
  }
}
