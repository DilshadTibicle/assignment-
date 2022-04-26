import 'package:goldenmovie/model/genre_item.dart';

class ResGenreItem {
  List<GenresItem>? genres;

  ResGenreItem({this.genres});

  ResGenreItem.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <GenresItem>[];
      json['genres'].forEach((v) {
        genres!.add(new GenresItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
