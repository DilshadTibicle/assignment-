import 'package:goldenmovie/model/top_rated_item.dart';

class ResTopRatedItem {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  ResTopRatedItem({this.page, this.results, this.totalPages, this.totalResults});

  ResTopRatedItem.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
