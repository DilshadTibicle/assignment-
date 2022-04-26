

import 'package:goldenmovie/data_source/movie_ds.dart';
import 'package:goldenmovie/database/genre_db.dart';
import 'package:goldenmovie/mapper/genre_mapper.dart';
import 'package:goldenmovie/mapper/movie_detail_mapper.dart';
import 'package:goldenmovie/mapper/now_playing_mapper.dart';
import 'package:goldenmovie/mapper/popular_mapper.dart';
import 'package:goldenmovie/mapper/search_mapper.dart';
import 'package:goldenmovie/mapper/top_rated_mapper.dart';
import 'package:goldenmovie/mapper/upcominf_mapper.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/model/popular_movie_item.dart';
import 'package:goldenmovie/model/search_item.dart';
import 'package:goldenmovie/model/top_rated_item.dart';
import 'package:goldenmovie/model/upcoming_movie_item.dart';

class MovieRepo {
  final nowPlayingMapper = NowPlayingMapper();
  final pupularMapper = PopularMapper();
  final topRatedMapper = TopRatedMapper();
  final upcomingMapper = UpcomingMapper();
  final movieDetailMapper = MovieDetailMapper();
  final movieDs = MovieDs();
  final searchMapper = SearchMapper();
  final genreMapper = GenreMapper();
  final genreDb = GenreDatabse.instance;

  Stream<NowPlayingItem> getNowPlayingData(int currentPage) {
    return movieDs
        .getNowPlaying(currentPage)
        .map((event) => nowPlayingMapper.map(event));
  }

  Stream<PopularMovieItem> getPopularMovie(int page) {
    return movieDs
        .getPopularMovie(page)
        .map((event) => pupularMapper.map(event));
  }

  Stream<TopRatedItem> getTopRatedItem(int page) {
    return movieDs
        .getTopRetedMovie(page)
        .map((event) => topRatedMapper.map(event));
  }

  Stream<UpcomingMovieItem> getUpcomingMovie(int page) {
    return movieDs
        .getUpComingMovie(page)
        .map((event) => upcomingMapper.map(event));
  }

  Stream<MovieDetailItem> getMovieDetail(int movieId) {
    return movieDs
        .getMovieDetail(movieId)
        .map((event) => movieDetailMapper.map(event));
  }

  Stream<SearchItem> getSearchItem({String? query, int? page}) {
    return movieDs
        .getSearchItem(query: query, page: page)
        .map((event) => searchMapper.map(event));
  }

  Stream<GenreItemList> getGenreItem() {
    return movieDs.getGenreItems().map((event) => genreMapper.map(event));
  }

  Stream<int?> insertGenreIntoDb( List<GenresItem> gens) {
    return Stream.fromFuture(genreDb.insertGenreIntoDb(gens));


  }

  Stream<GenreItemList> getGenreFromDb(){
    return Stream.fromFuture(genreDb.getGenreFromDb2());
  }
}
