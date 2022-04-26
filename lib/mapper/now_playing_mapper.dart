import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/response/now_playing_response.dart';

class NowPlayingMapper extends BaseMapper<ResNowPlaying, NowPlayingItem> {
  @override
  NowPlayingItem map(ResNowPlaying t) {
    return NowPlayingItem(
        page: t.page,
        results: t.results,
        dates: t.dates,
        totalPages: t.totalPages,
        totalResults: t.totalPages);
  }
}
