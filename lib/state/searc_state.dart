import 'package:goldenmovie/model/search_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class SearchState extends BaseUiState<SearchItem> {
  SearchState.loading() : super.loading();

  SearchState.completed(SearchItem data) : super.completed(data: data);

  SearchState.error(dynamic error) : super.error(error);
}
