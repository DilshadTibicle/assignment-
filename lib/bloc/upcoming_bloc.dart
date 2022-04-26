import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/bloc/genre_bloc.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/upcoming_movie_item.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/upcoming_movie_state.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingMovieBloc extends BaseBloc {
  final upcomingState = BehaviorSubject<UpcomingMovieState>();
  final upcomingRepo = MovieRepo();
  final upcomingMovie = BehaviorSubject<UpcomingMovieItem>();
  final genreBloc = GenreBloc.instance;
  final loadingMore = BehaviorSubject.seeded(false);

  int currentPage = 1;
  int? maxPage;

  void getupcomingMovie() {
    if (maxPage != null && currentPage > maxPage!) {
      return;
    }
    currentPage == 1
        ? upcomingState.add(UpcomingMovieState.loading())
        : loadingMore.add(true);
    subscription.add(upcomingRepo
        .getUpcomingMovie(currentPage)
        .map((data) => UpcomingMovieState.completed(data))
        .onErrorReturnWith((error, _) => UpcomingMovieState.error(error))
        .startWith(UpcomingMovieState.loading())
        .listen((state) {
      if (state.isCompleted() || currentPage == 1) {
        upcomingState.add(state);
        loadingMore.add(false);
      }

      if (state.isCompleted()) {
        final newList = state.data?.results ?? List.empty(growable: true);

        final currentList =
            upcomingMovie.valueOrNull?.results ?? List.empty(growable: true);

        currentList.addAll(newList);
        var nowPlayingData = UpcomingMovieItem(
            results: currentList, totalPages: state.data?.totalPages);
        currentPage++;
        upcomingMovie.add(nowPlayingData);
        upcomingState.add(UpcomingMovieState.completed(nowPlayingData));

        /// Itrating for genre data to load and add to genre model


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
        // state.data?.results?.forEach((e) {
        //   e.genreIds?.forEach((genreIds) {
        //     genreBloc.genreState.valueOrNull?.data?.genres?.forEach((event) {
        //       if (event.id == genreIds) {
        //         print("ELEMENT OF STATE");
        //
        //         state.data?.results?.forEach((element) {
        //           var genre = GenresItem(id: event.id, name: event.name);
        //           if (element.genre != null) {
        //             element.genre?.add(genre);
        //           }
        //           print(event.id);
        //
        //           print("RESULT ID");
        //           print(genreIds);
        //         });
        //       }
        //     });
        //   });
        // });






      }
    }, onError: (error) {
      print("////ERROR");
    }));
  }
}
