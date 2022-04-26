import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/top_rated_item.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/top_rated_state.dart';
import 'package:rxdart/rxdart.dart';

import 'genre_bloc.dart';

class TopRatedBloc extends BaseBloc {
  final topRatesState = BehaviorSubject<TopRatedState>();
  final movieRepo = MovieRepo();
  final topRated = BehaviorSubject<TopRatedItem>();
  final genreBloc = GenreBloc.instance;

  int currentPage = 1;
  int? maxPage;

  final loadingMore = BehaviorSubject.seeded(false);

  void getTopRatedData() {
    if (maxPage != null && currentPage > maxPage!) {
      return;
    }
    currentPage == 1
        ? topRatesState.add(TopRatedState.loading())
        : loadingMore.add(true);
    subscription.add(movieRepo
        .getTopRatedItem(currentPage)
        .map((data) => TopRatedState.completed(data))
        .onErrorReturnWith((error, _) => TopRatedState.error(error))
        .startWith(TopRatedState.loading())
        .listen((state) {
      if (state.isCompleted() || currentPage == 1) {
        topRatesState.add(state);
        loadingMore.add(false);
      }

      if (state.isCompleted()) {
        final newList = state.data?.results ?? List.empty(growable: true);

        final currentList =
            topRated.valueOrNull?.results ?? List.empty(growable: true);
        currentList.addAll(newList);
        var nowPlayingData = TopRatedItem(
            results: currentList, totalPages: state.data?.totalPages);
        currentPage++;
        topRated.add(nowPlayingData);
        topRatesState.add(TopRatedState.completed(nowPlayingData));

        /// Itrating for genre data to load and add to genre model
        state.data?.results?.forEach((e) {
          print("List<Int> of Genre ID");
          print("List<Int> of Genre ID");
          print(e.genreIds);

          for (var g in e.genreIds!) {
            var index = genreBloc.genreState.valueOrNull?.data?.genres
                ?.indexWhere((element) => element.id == g);
            if (index != null && index != -1) {
              var gener =
                  genreBloc.genreState.valueOrNull?.data?.genres![index];
              if (gener != null) {
                e.genre?.add(gener);
              }
              print(gener);
            }

            // break;
          }
        });
      }
    }, onError: (error) {
      print("////ERROR");
    }));
  }
}
