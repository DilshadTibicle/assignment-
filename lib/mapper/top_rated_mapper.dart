import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/top_rated_item.dart';
import 'package:goldenmovie/response/top_rated_response.dart';

class TopRatedMapper extends BaseMapper<ResTopRatedItem, TopRatedItem> {
  @override
  TopRatedItem map(ResTopRatedItem t) {
    return TopRatedItem(
        totalPages: t.totalPages,
        results: t.results,
        totalResults: t.totalResults,
        page: t.page);
  }
}
