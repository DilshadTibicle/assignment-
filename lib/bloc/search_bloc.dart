import 'package:goldenmovie/bloc/base_bloc/base_bloc.dart';
import 'package:goldenmovie/model/search_item.dart';
import 'package:goldenmovie/repo/movie_repo.dart';
import 'package:goldenmovie/state/searc_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc {
  final searchState = BehaviorSubject<SearchState>();
  final searchrepo = MovieRepo();
  final searchItem = BehaviorSubject<SearchItem>();

  void getSearchItem(String query) {
    searchState.add(SearchState.loading());
    subscription.add(searchrepo
        .getSearchItem(query: query)
        .map((event) => SearchState.completed(event))
        .onErrorReturnWith((error, stackTrace) => SearchState.error(error))
        .startWith(SearchState.loading())
        .listen((event) {
      searchState.add(event);
    }));
  }
}
