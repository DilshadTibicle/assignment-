import 'package:flutter/material.dart';
import 'package:goldenmovie/bloc/search_bloc.dart';
import 'package:goldenmovie/state/searc_state.dart';
import 'package:goldenmovie/ui/screen/movie_detail.dart';

class ListSearch extends StatefulWidget {
  String searchQuery;

  ListSearch(this.searchQuery);

  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {
  final TextEditingController _textController = TextEditingController();
  final searchBloc = SearchBloc();

  onItemChanged(String value) {
    searchBloc.getSearchItem(value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc.getSearchItem("s");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Search Here...',
          ),
          onChanged: onItemChanged,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<SearchState>(
              stream: searchBloc.searchState,
              builder: (context, snapshot) {
                SearchState? state = snapshot.data;
                if (state == null) return Container();
                if (state.isLoading()) {
                  return const Center(child: CircularProgressIndicator());
                }
                ;
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                  ),
                  itemCount: state.data?.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    String? backdrop = state.data?.results?[index].posterPath??"";
                    String? givenLink = "https://image.tmdb.org/t/p/original";
                    final posterpath = givenLink + backdrop;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                  movieId: state.data?.results?[index].id ?? 0),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  child: Text(
                                    state.data?.results?[index].title ?? "",
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  child: Text(
                                    state.data?.results?[index].releaseDate ??
                                        "",
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  child: Text(
                                    "${state.data?.results?[index].voteAverage ?? ""}",
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  child: Text(
                                    "${state.data?.results?[index].voteCount ?? ""}",
                                  ),
                                ),
                              ],
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

// Search bar in app bar flutter
// class SearchAppBar extends StatefulWidget {
//   @override
//   _SearchAppBarState createState() => _SearchAppBarState();
// }
//
// class _SearchAppBarState extends State<SearchAppBar> {
//   Widget appBarTitle = const Text("AppBar Title");
//   Icon actionIcon = const Icon(Icons.search);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           title:appBarTitle,
//           actions: <Widget>[
//             IconButton(icon: actionIcon,onPressed:(){
//               setState(() {
//                 if ( this.actionIcon.icon == Icons.search){
//                   this.actionIcon = const Icon(Icons.close);
//                   this.appBarTitle = const TextField(
//                     style: const TextStyle(
//                       color: Colors.white,
//
//                     ),
//                     decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.search,color: Colors.white),
//                         hintText: "Search...",
//                         hintStyle: const TextStyle(color: Colors.white)
//                     ),
//                   );}
//                 else {
//                   this.actionIcon = const Icon(Icons.search);
//                   this.appBarTitle = const Text("AppBar Title");
//                 }
//
//
//               });
//             } ,),]
//       ),
//     );
//   }
// }
