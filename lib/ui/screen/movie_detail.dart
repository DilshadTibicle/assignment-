import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goldenmovie/bloc/favourite_bloc.dart';
import 'package:goldenmovie/bloc/movie_Detail_bloc.dart';
import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/repo/fav%20repo.dart';
import 'package:goldenmovie/state/add_fav_state.dart';
import 'package:goldenmovie/state/movie_detail.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailPage extends StatefulWidget {
  List<GenresItem>? movie;
  List<Genres>? genresMovie;
  int? movieId;

  MovieDetailPage({this.genresMovie, this.movieId, this.movie, Key? key})
      : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final movieDetailBloc = MovieDetailBloc();
  final fovouriteBloc = FavouriteBloc.instance;
  MovieDetailItem? movieDetailItem;
  final favRepo = FavRepo();

  bool hide = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailBloc.movieDetail(widget.movieId ?? 0);
    // fovouriteBloc.loadFavItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie Detail"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<MovieDetailState>(
                  stream: movieDetailBloc.movieDetailState,
                  builder: (context, snapshot) {
                    MovieDetailState? state = snapshot.data;
                    String? givenLink = "https://image.tmdb.org/t/p/original";
                    String? backdrop =
                        givenLink + "${state?.data?.backdropPath}";
                    String? poster = givenLink + "${state?.data?.posterPath}";
                    var releaseDate = state?.data?.releaseDate??"";
                    String?dateFormate;
                    if(releaseDate!=null && releaseDate!=""){
                      dateFormate = DateFormat("dd-MMM-yyyy")
                          .format(DateTime.parse(releaseDate));
                    }


                    if (state == null) return Container();
                    if (state.isLoading()) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    ;
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(child: Image.network(backdrop)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 150, horizontal: 20),
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical:3),
                                      child: Image.network(poster,height: 200,)),


                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 190,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [

                                              Text("Tittle:"),
                                              Text("TagLine:"),
                                              Text("Release Date:"),
                                              Text("Vote count:"),
                                              Text("vote average:"),
                                              Text("spoken language:"),
                                              Text("Status:"),
                                              Text("Genre:"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 190,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(state.data?.title ?? ""),
                                            Text(state.data?.tagline ?? ""),
                                            Text(dateFormate!),
                                            Text(state.data?.voteCount
                                                    .toString() ??
                                                ""),
                                            Text(state.data?.voteAverage
                                                    .toString() ??
                                                ""),
                                            Text(state.data?.spokenLanguages?[0]
                                                    .name
                                                    .toString() ??
                                                ""),
                                            Text(
                                                state.data?.status.toString() ??
                                                    ""),
                                            Text(widget.movie
                                                    ?.map((e) => e.name)
                                                    .toList()
                                                    .join(" || ") ??
                                                widget.genresMovie
                                                    ?.map((e) => e.name)
                                                    .toList()
                                                    .join(" || ") ??
                                                "")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                    child: Text("Overview:"),
                                  ),   Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                    child: Text(state.data?.overview ?? ""),
                                  ),
                                  StreamBuilder<AddToFavState>(
                                    stream: fovouriteBloc.favState,
                                    builder: (context, snapshot) {
                                      fovouriteBloc
                                          .favState.valueOrNull?.data?.movie
                                          ?.forEach((element) {
                                        if (widget.movieId == element.id) {
                                          movieDetailBloc.isAdded.add(true);
                                        }
                                      });
                                      return StreamBuilder(
                                        stream: movieDetailBloc.isAdded,
                                        builder: (context, snapshot) {
                                          return movieDetailBloc
                                                      .isAdded.valueOrNull ==
                                                  true
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    fovouriteBloc.removeFromFav(
                                                        state.data?.id);
                                                    movieDetailBloc.isAdded
                                                        .add(false);
                                                  },
                                                  child:
                                                      Text("Remove From Fav"))
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    movieDetailBloc.isAdded
                                                        .add(true);
                                                    fovouriteBloc
                                                        .addToFavourite([
                                                      state.data!,
                                                    ]);
                                                  },
                                                  child: Text("Add to Fav"));
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
