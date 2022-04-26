import 'package:flutter/material.dart';
import 'package:goldenmovie/bloc/favourite_bloc.dart';
import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:goldenmovie/state/add_fav_state.dart';
import 'package:goldenmovie/ui/screen/movie_detail.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final favouriteBloc = FavouriteBloc.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteBloc.loadFavItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Favourite Items"),),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<AddToFavState>(
                  stream: favouriteBloc.favState,
                  builder: (context, snapshot) {
                    AddToFavState? state = snapshot.data;

                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 6,
                      ),
                      //ßshrinkWrap: true,
                      itemCount:state?.data?.movie?.length ?? 0,
                      itemBuilder: (context, index) {
                        String? backdrop =state?.data?.movie?[index].posterPath;
                        String? givenLink = "https://image.tmdb.org/t/p/original";
                        final posterpath = givenLink + backdrop!;

                        // var state= snapshot.data?.movie?[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(
                                      movieId: state?.data?.movie?[index].id ?? 0,genresMovie: state?.data?.movie?[index].genres,),
                                ));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: Image.network(
                                    posterpath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),

                                        child: Text(
                                          state?.data?.movie?[index].title??"",
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),

                                        child: Text(
                                          state?.data?.movie?[index].releaseDate ??
                                              "",
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),

                                        child: Text(
                                          "${state?.data?.movie?[index].voteAverage?? ""}",
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),

                                        child: Text(
                                          "${state?.data?.movie?[index].voteCount ?? ""}",
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Text(state
                                              ?.data?.movie?[index].genres
                                              ?.map((e) => e.name).toList().join(" || ")??
                                              "")),
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
        ),
      ),
    );
  }
}
