import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/repo/fav%20repo.dart';
import 'package:goldenmovie/state/add_fav_state.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteBloc extends BaseBloc {
  FavouriteBloc._();

  static final FavouriteBloc instance = FavouriteBloc._();

  final favRepo = FavRepo();
  final favItemList = BehaviorSubject<FavItemList>();
  final favState = BehaviorSubject<AddToFavState>();

  void addToFavourite(List<MovieDetailItem> movie) {
    subscription.add(favRepo
        .addTofav(
      movie,
    )
        .listen((event) {
      Fluttertoast.showToast(
          msg: "Added to Favorite", backgroundColor: Colors.teal.shade300);
      favState.add(AddToFavState.completed(favItemList.valueOrNull!));
    }));
  }

  /// from database
  // void addToFavouritefromDb(MovieDetailItem movie) {
  //   subscription.add(favRepo.addTofav(movie).listen((event) {
  //     // loadFav();
  //   }));
  // }
  // }

  /// from database and shared preferences both

  loadFavItems() {
    favState.add(AddToFavState.loading());
    subscription.add(favRepo
        .getFav()
        .map((data) => AddToFavState.completed(data))
        .onErrorReturnWith((error, stackTrace) => AddToFavState.error(error))
        .startWith(AddToFavState.loading())
        .listen((state) {
      if (state.isCompleted()) {
        favState.add(state);
      }
      if (state.isCompleted()) {
        var newId;
        var curentId;

        state.data?.movie?.forEach((element) {
          newId = element.id;
        });

        favItemList.valueOrNull?.movie?.forEach((element) {
          curentId = element.id;
        });

        final newList = state.data?.movie ?? List.empty(growable: true);
        final currentList =
            favItemList.valueOrNull?.movie ?? List.empty(growable: true);
        if (newId != curentId) {
          currentList.addAll(newList);
        }
        var favItems = FavItemList(movie: currentList);
        favItemList.add(favItems);
        favState.add(AddToFavState.completed(favItems));
      }
    }));
  }

  void removeFromFav(int? id) {
    favItemList.valueOrNull?.movie?.removeWhere((element) => element.id == id);
    var favItems = FavItemList(movie: favItemList.valueOrNull?.movie);
    favItemList.add(favItems);
    subscription.add(
        favRepo.addTofav(favItemList.valueOrNull?.movie ?? []).listen((event) {
      favState.add(AddToFavState.completed(favItemList.valueOrNull!));
      Fluttertoast.showToast(
          msg: "Removed from Favourite", backgroundColor: Colors.teal.shade300);
    }));
  }
}
