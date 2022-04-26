class GenreItemList {
  List<GenresItem>? genres;

  GenreItemList({this.genres});

}

class GenresItem {
  int? id;
  String? name;

  GenresItem({this.id, this.name});

  GenresItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
