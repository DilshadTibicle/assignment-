import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/response/movie_detail_res.dart';

class MovieDetailMapper
    extends BaseMapper<ResMovieDetailItem, MovieDetailItem> {
  @override
  MovieDetailItem map(ResMovieDetailItem t) {
    return MovieDetailItem(
        adult: t.adult,
        backdropPath: t.backdropPath,
        belongsToCollection: t.belongsToCollection,
        budget: t.budget,
        genres: t.genres,
        homepage: t.homepage,
        id: t.id,
        imdbId: t.imdbId,
        originalLanguage: t.originalLanguage,
        originalTitle: t.originalTitle,
        overview: t.overview,
        popularity: t.popularity,
        posterPath: t.posterPath,
        productionCompanies: t.productionCompanies,
        productionCountries: t.productionCountries,
        releaseDate: t.releaseDate,
        revenue: t.revenue,
        runtime: t.runtime,
        spokenLanguages: t.spokenLanguages,
        status: t.status,
        tagline: t.tagline,
        title: t.title,
        video: t.video,
        voteAverage: t.voteAverage,
        voteCount: t.voteCount);
  }
}
