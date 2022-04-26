import 'dart:math';

import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/genre_state.dart';
import 'package:rxdart/rxdart.dart';

class GenreBloc extends BaseBloc {
  final genreRepo = MovieRepo();
  final genreState = BehaviorSubject<GenreState>();
  final genrename = BehaviorSubject<GenresItem>();
  final name = BehaviorSubject<String>();

  GenreBloc._();

  static final GenreBloc instance = GenreBloc._();

  void getGenre(/*List<Results>? results*/) {

    genreState.add(GenreState.loading());
    subscription.add(genreRepo
        .getGenreItem()
        .map((event) => GenreState.completed(event))
        .onErrorReturnWith((error, stackTrace) => GenreState.error(error))
        .startWith(GenreState.loading())
        .listen((event) {
      genreState.add(event);
      if (event.isCompleted()) {




        // results?.forEach((e) {
        //   e.genreIds?.forEach((genreIds) {
        //     event.data?.genres?.forEach((event) {
        //       if (event.id == genreIds) {
        //         print("ELEMENT OF STATE");
        //
        //         results.forEach((element) {
        //           var genre=GenresItem(id: event.id, name: event.name);
        //           if(element.genre!=null){
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

    }, onError: (e) {
      print("ERROR");
      print("ERROR");
      print("ERROR");
    }));
  }

  void getGenreFromDb() {
    genreState.add(GenreState.loading());
    subscription.add(genreRepo
        .getGenreFromDb()
        .map((event) => GenreState.completed(event))
        .onErrorReturnWith((error, stackTrace) => GenreState.error(error))
        .startWith(GenreState.loading())
        .listen((event) {
      genreState.add(event);
    }));
  }
}
