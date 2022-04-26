import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/bloc/genre_bloc.dart';
import 'package:goldenmovie/repo/fav%20repo.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/movie_detail.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BaseBloc {
  final movieDetailRepo = MovieRepo();
  final movieDetailState = BehaviorSubject<MovieDetailState>();
  final isAdded = BehaviorSubject<bool>.seeded(false);
final genreBloc=GenreBloc.instance;

  FavRepo favRepo = FavRepo();

  void movieDetail(int movieId) {
    movieDetailState.add(MovieDetailState.loading());
    subscription.add(movieDetailRepo
        .getMovieDetail(movieId)
        .map((data) => MovieDetailState.completed(data))
        .onErrorReturnWith((error, stackTrace) => MovieDetailState.error(error))
        .startWith(MovieDetailState.loading())
        .listen((state) {
      movieDetailState.add(state);

      print("//////////");
      print("//////////");
      print("//////////");
      print(state.data);
    }, onError: (e) {
      print("ERROR");
      print(e);
    }));
  }
}
