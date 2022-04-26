import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class MovieDetailState extends BaseUiState<MovieDetailItem> {
  MovieDetailState.loading() : super.loading();

  MovieDetailState.completed(MovieDetailItem data)
      : super.completed(data: data);

  MovieDetailState.error(dynamic error) : super.error(error);
}
