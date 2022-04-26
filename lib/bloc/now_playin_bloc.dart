import 'dart:math';

import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/bloc/genre_bloc.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/genre_state.dart';
import 'package:goldenmovie/state/now%20playing%20state.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingBloc extends BaseBloc {
  final nowPlayingState = BehaviorSubject<NowPlayingState>();
  final nowPlyingRepo = MovieRepo();
  final nowPalying = BehaviorSubject<NowPlayingItem>();
  final genreBloc = GenreBloc.instance;
  final releaseDate = BehaviorSubject<String>();

  int currentPage = 1;
  int? maxPage;

  final loadingMore = BehaviorSubject.seeded(false);

  void getNowPalying() async {
    if (maxPage != null && currentPage > maxPage!) {
      return;
    }
    currentPage == 1
        ? nowPlayingState.add(NowPlayingState.loading())
        : loadingMore.add(true);
    subscription.add(nowPlyingRepo
        .getNowPlayingData(currentPage)
        .map((data) => NowPlayingState.completed(data))
        .onErrorReturnWith((error, _) => NowPlayingState.error(error))
        .startWith(NowPlayingState.loading())
        .listen((state) {
      var rDate;
      state.data?.results?.forEach((element) {
        rDate = element.releaseDate;
      });

      // state.data?.results?.forEach((element) {
      //   releaseDate.add(DateFormat("dd-MMM-yyyy")
      //       .format(DateTime.parse(element.releaseDate!)));
      // });

      if (state.isCompleted() || currentPage == 1) {
        nowPlayingState.add(state);
        loadingMore.add(false);
      }

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

      if (state.isCompleted()) {
        final newList = state.data?.results ?? List.empty(growable: true);
        final currentList =
            nowPalying.valueOrNull?.results ?? List.empty(growable: true);

        currentList.addAll(newList);
        var nowPlayingData = NowPlayingItem(
            results: currentList, totalPages: state.data?.totalPages);
        currentPage++;
        nowPalying.add(nowPlayingData);
        nowPlayingState.add(NowPlayingState.completed(nowPlayingData));
      }
    }, onError: (error) {
      print("////ERROR");
    }));
  }
}
