import 'package:goldenmovie/model/popular_movie_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class PopularState extends BaseUiState<PopularMovieItem> {
  PopularState.loading() :super.loading();

  PopularState.completed(PopularMovieItem data) :super.completed(data: data);

  PopularState.error(dynamic error) :super.error(error);
}