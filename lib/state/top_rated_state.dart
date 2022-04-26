import 'package:goldenmovie/model/top_rated_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class TopRatedState extends BaseUiState<TopRatedItem> {
  TopRatedState.loading() : super.loading();

  TopRatedState.completed(TopRatedItem data) : super.completed(data: data);

  TopRatedState.error(dynamic error) : super.error(error);
}
