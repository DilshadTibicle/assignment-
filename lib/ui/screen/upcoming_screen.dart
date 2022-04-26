import 'package:flutter/material.dart';
import 'package:goldenmovie/bloc/upcoming_bloc.dart';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/state/upcoming_movie_state.dart';
import 'package:goldenmovie/ui/screen/movie_detail.dart';
import 'package:intl/intl.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final upcomingMovieBloc = UpcomingMovieBloc();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upcomingMovieBloc.getupcomingMovie();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        upcomingMovieBloc.getupcomingMovie();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<UpcomingMovieState>(
              stream: upcomingMovieBloc.upcomingState,
              builder: (context, snapshot) {
                UpcomingMovieState? state = snapshot.data;
                if (state == null) return Container();
                if (state.isLoading()) {
                  return Center(child: CircularProgressIndicator());
                }
                ;
                return ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 6,
                  ),
                  itemCount: state.data?.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    String? backdrop = state.data?.results?[index].posterPath??"";
                    String? givenLink = "https://image.tmdb.org/t/p/original";
                    final posterpath = givenLink + backdrop;


                    var releaseDate = state.data?.results?[index].releaseDate??"";
                    var dateFormate =
                    DateFormat("dd-MMM-yyyy").format(DateTime.parse(releaseDate));



                    return index == (state.data?.results?.length)! - 1
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: StreamBuilder<bool>(
                                stream: upcomingMovieBloc.loadingMore,
                                builder: (context, snapshot) {
                                  return (snapshot.data ?? false)
                                      ? CircularProgressIndicator()
                                      : SizedBox(height: 0);
                                }),
                          )
                        : InkWell(
                            onTap: () {
                              List<GenresItem>? genreItem =
                                  state.data?.results?[index].genre;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailPage(
                                      movieId:
                                          state.data?.results?[index].id ?? 0,movie: state.data?.results?[index].genre,
                                    ),
                                  ));
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Image.network(
                                      posterpath,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),

                                          child: Text(
                                            state.data?.results?[index].title ??
                                                "",
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),

                                          child: Text(
                                            dateFormate,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),

                                          child: Text(
                                            "${state.data?.results?[index].voteAverage ?? ""}",
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.4,
                                            child: Text(state
                                                    .data?.results?[index].genre
                                                    ?.map((e) => e.name).toList().join(" || ")??
                                                "")),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),

                                          child: Text(
                                            "${state.data?.results?[index].voteCount ?? ""}",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
