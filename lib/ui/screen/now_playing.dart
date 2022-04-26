import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goldenmovie/bloc/favourite_bloc.dart';
import 'package:goldenmovie/bloc/genre_bloc.dart';
import 'package:goldenmovie/bloc/now_playin_bloc.dart';
import 'package:goldenmovie/model/now_playing_item.dart';
import 'package:goldenmovie/state/now%20playing%20state.dart';
import 'package:goldenmovie/ui/screen/movie_detail.dart';
import 'package:intl/intl.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  final nowPlayingBloc = NowPlayingBloc();
  final ScrollController _scrollController = ScrollController();
  final genreBloc = GenreBloc.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      nowPlayingBloc.getNowPalying();
    });

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        nowPlayingBloc.getNowPalying();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<NowPlayingState>(
              stream: nowPlayingBloc.nowPlayingState,
              builder: (context, snapshot) {
                NowPlayingState? state = snapshot.data;
                if (state == null) return Container();
                if (state.isLoading()) {
                  return const Center(child: const CircularProgressIndicator());
                }
                ;
                return ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                  ),
                  itemCount: state.data?.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    String? backdrop =
                        state.data?.results?[index].posterPath ?? "";
                    String? givenLink = "https://image.tmdb.org/t/p/original";
                    final posterpath = givenLink + backdrop;
                    var releaseDate = state.data?.results?[index].releaseDate;
                    var dateFormate =
                    DateFormat("dd-MMM-yyyy").format(DateTime.parse(releaseDate!));



                    return index == (state.data?.results?.length)! - 1
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: StreamBuilder<bool>(
                                stream: nowPlayingBloc.loadingMore,
                                builder: (context, snapshot) {
                                  return (snapshot.data ?? true)
                                      ? const CircularProgressIndicator()
                                      : const SizedBox(height: 0);
                                }),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailPage(
                                      movieId:
                                          state.data?.results?[index].id ?? 0,
                                      movie: state.data?.results?[index].genre,
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                Card(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Image.network(
                                          posterpath,
                                          fit: BoxFit.cover,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: Text(
                                                // DateFormat.ABBR_MONTH
                                                state.data?.results?[index]
                                                        .title ??
                                                    "",
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: Text(
                                                dateFormate,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: Text(
                                                "${state.data?.results?[index].voteAverage ?? ""}",
                                              ),
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5),
                                                child: Text(state.data
                                                        ?.results?[index].genre
                                                        ?.map((e) => e.name)
                                                        .toList()
                                                        .join(" || ") ??
                                                    "")),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
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
                              ],
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
