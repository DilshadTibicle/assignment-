import 'package:goldenmovie/model/upcoming_movie_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class UpcomingMovieState extends BaseUiState<UpcomingMovieItem> {
  UpcomingMovieState.loading() : super.loading();

  UpcomingMovieState.completed(UpcomingMovieItem data) : super.completed(data: data);

  UpcomingMovieState.error(dynamic error) : super.error(error);
}
