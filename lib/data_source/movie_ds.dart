import 'package:dio/dio.dart';
import 'package:goldenmovie/response/genre_res.dart';
import 'package:goldenmovie/response/movie_detail_res.dart';
import 'package:goldenmovie/response/now_playing_response.dart';
import 'package:goldenmovie/response/popular_movie_response.dart';
import 'package:goldenmovie/response/serach_res.dart';
import 'package:goldenmovie/response/top_rated_response.dart';
import 'package:goldenmovie/response/up_coming_response.dart';
import 'package:goldenmovie/rest_cliet/app_constant.dart';
import 'package:goldenmovie/rest_cliet/rest_client.dart';

class MovieDs {
  Stream<ResNowPlaying> getNowPlaying(int currentPage) {
    return Stream.fromFuture(RestClient()
        .getDio()
        .get(AppConstants.basUrl + "movie/now_playing", queryParameters: {
      "page": currentPage,
      "api_key": AppConstants.api_key
    })).map((event) {
      print(event.data);
      return ResNowPlaying.fromJson(event.data);
    });
  }

  Stream<ResPopularMovieItem> getPopularMovie(int page) {
    return Stream.fromFuture(RestClient().getDio().get(
            AppConstants.basUrl + "movie/popular",
            queryParameters: {"page": page, "api_key": AppConstants.api_key}))
        .map((event) {
      print(event.data);
      return ResPopularMovieItem.fromJson(event.data);
    });
  }

  Stream<ResTopRatedItem> getTopRetedMovie(int page) {
    return Stream.fromFuture(RestClient().getDio().get(
            AppConstants.basUrl + "movie/top_rated",
            queryParameters: {"page": 1, "api_key": AppConstants.api_key}))
        .map((event) {
      return ResTopRatedItem.fromJson(event.data);
    });
  }

  Stream<ResUpcomingMovie> getUpComingMovie(int page) {
    return Stream.fromFuture(RestClient().getDio().get(
            AppConstants.basUrl + "movie/upcoming",
            queryParameters: {"page": page, "api_key": AppConstants.api_key}))
        .map((event) => ResUpcomingMovie.fromJson(event.data));
  }

  Stream<ResMovieDetailItem> getMovieDetail(int movieId) {
    return Stream.fromFuture(RestClient()
        .getDio()
        .get(AppConstants.basUrl + "movie/" + "$movieId", queryParameters: {
      "api_key": AppConstants.api_key,
    })).map((event) {
      return ResMovieDetailItem.fromJson(event.data);
    });
  }

  Stream<ResSearchItem> getSearchItem({String? query, int? page}) {
    return Stream.fromFuture(RestClient()
        .getDio()
        .get(AppConstants.basUrl + "search/movie", queryParameters: {
      "query": query,
      "page": page,
      "api_key": AppConstants.api_key,
    })).map((event) => ResSearchItem.fromJson(event.data));
  }

  Stream<ResGenreItem> getGenreItems() {
    return Stream.fromFuture(RestClient().getDio().get(
            AppConstants.basUrl + "genre/movie/list",
            queryParameters: {"api_key": AppConstants.api_key}))
        .map((event) => ResGenreItem.fromJson(event.data));
  }
}
