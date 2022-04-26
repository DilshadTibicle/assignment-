import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class AddToFavState extends BaseUiState<FavItemList> {
  AddToFavState.loading() : super.loading();

  AddToFavState.completed(FavItemList data) : super.completed(data: data);

  AddToFavState.error(dynamic error) : super.error(error);
}
