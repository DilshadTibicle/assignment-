import 'package:goldenmovie/model/popular_movie_item.dart';

class ResPopularMovieItem {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  ResPopularMovieItem(
      {this.page, this.results, this.totalPages, this.totalResults});

  ResPopularMovieItem.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
