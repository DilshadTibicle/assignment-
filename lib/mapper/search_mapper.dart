import 'package:goldenmovie/mapper/base_mapper/bse_mapper.dart';
import 'package:goldenmovie/model/search_item.dart';
import 'package:goldenmovie/response/serach_res.dart';

class SearchMapper extends BaseMapper<ResSearchItem, SearchItem> {
  @override
  SearchItem map(ResSearchItem t) {
    return SearchItem(
        totalResults: t.totalResults,
        page: t.page,
        results: t.results,
        totalPages: t.totalPages);
  }
}
