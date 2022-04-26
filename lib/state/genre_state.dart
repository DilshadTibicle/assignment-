import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class GenreState extends BaseUiState<GenreItemList> {
  GenreState.loading() : super.loading();

  GenreState.completed(GenreItemList data) : super.completed(data: data);

  GenreState.error(dynamic error) : super.error(error);
}
