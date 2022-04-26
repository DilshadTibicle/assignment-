import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/state/Base_ui/base_ui_state.dart';

class NowPlayingState extends BaseUiState<NowPlayingItem> {
  NowPlayingState.loading() : super.loading();

  NowPlayingState.completed(NowPlayingItem data) : super.completed(data: data);

  NowPlayingState.error(dynamic error) : super.error(error);
}
