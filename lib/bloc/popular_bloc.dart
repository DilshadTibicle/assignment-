import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/popular_movie_item.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/popular_state.dart';
import 'package:rxdart/rxdart.dart';

import 'genre_bloc.dart';

class PopularBloc extends BaseBloc {
  final popularState = BehaviorSubject<PopularState>();
  final movieRepo = MovieRepo();
  final popularPlaying = BehaviorSubject<PopularMovieItem>();
  final loadMore = BehaviorSubject.seeded(false);
  final genreBloc = GenreBloc.instance;

  int currentPage = 1;
  int? maxPage;

  void getPopularData()async {
    if (maxPage != null && currentPage > maxPage!) {
      return;
    }
    currentPage == 1
        ? popularState.add(PopularState.loading())
        : loadMore.add(true);
    subscription.add(movieRepo
        .getPopularMovie(currentPage)
        .map((data) => PopularState.completed(data))
        .onErrorReturnWith((error, _) => PopularState.error(error))
        .startWith(PopularState.loading())
        .listen((state) {
      if (state.isCompleted() || currentPage == 1) {
        popularState.add(state);
        loadMore.add(false);
        print(state.data);
      }
      if (state.isCompleted()) {
        final newList = state.data?.results ?? List.empty(growable: true);
        final currentList =
            popularPlaying.valueOrNull?.results ?? List.empty(growable: true);

        currentList.addAll(newList);
        var popularPlayinData = PopularMovieItem(
            results: currentList, totalPages: state.data?.totalPages);
        currentPage++;
        popularPlaying.add(popularPlayinData);
        popularState.add(PopularState.completed(popularPlayinData));

        /// Iterating for genre data to load and add to genre model
        state.data?.results?.forEach((e) {
          for (var g in e.genreIds!) {
            var index = genreBloc.genreState.valueOrNull?.data?.genres
                ?.indexWhere((element) => element.id == g);
            if (index != null && index != -1) {
              var gener = genreBloc.genreState.valueOrNull?.data?.genres![index];
              if (gener != null) {
                e.genre?.add(gener);
              }
              print(gener);
            }
            // break;
          }
        });
      }
    }));
  }
}
