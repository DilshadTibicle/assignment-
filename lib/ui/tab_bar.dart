import 'package:flutter/material.dart';
import 'package:goldenmovie/bloc/favourite_bloc.dart';
import 'package:goldenmovie/bloc/genre_bloc.dart';
import 'package:goldenmovie/bloc/now_playin_bloc.dart';
import 'package:goldenmovie/ui/screen/fav_screen.dart';
import 'package:goldenmovie/ui/screen/now_playing.dart';
import 'package:goldenmovie/ui/screen/popular_screen.dart';
import 'package:goldenmovie/ui/screen/search.dart';
import 'package:goldenmovie/ui/screen/top_rated.dart';
import 'package:goldenmovie/ui/screen/upcoming_screen.dart';

class TabBarScreen extends StatefulWidget {
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  final nowPlayingBloc = NowPlayingBloc();
  TextEditingController controller = TextEditingController();
  final genre = GenreBloc.instance;

  final genreBloc = GenreBloc.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genre.getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Assingment Golden Movie"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListSearch("red turning"),
                        ));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouriteScreen(),
                        ));
                  },
                  icon: Icon(Icons.favorite))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: "Now Playing"),
                Tab(text: "Popular"),
                Tab(text: "Top Rated"),
                Tab(text: "Upcoming")
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              NowPlayingScreen(),
              PopuplarScreen(),
              TopRatedScreen(),
              UpcomingScreen()
            ],
          ),
        ),
      ),
    );
  }
}

//
// class CustomSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return null;
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return null;
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     return null;
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     return null;
//   }
//
//
// }
//
// class CustomSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     if (query.length < 3) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: Text(
//               "Search term must be longer than two letters.",
//             ),
//           )
//         ],
//       );
//     }
//
//     //Add the search term to the searchBloc.
//     //The Bloc will then handle the searching and add the results to the searchResults stream.
//     //This is the equivalent of submitting the search term to whatever search service you are using
//     InheritedBlocs.of(context)
//         .searchBloc
//         .searchTerm
//         .add(query);
//
//     return Column(
//       children: <Widget>[
//         //Build the results based on the searchResults stream in the searchBloc
//         StreamBuilder(
//           stream: InheritedBlocs.of(context).searchBloc.searchResults,
//           builder: (context, AsyncSnapshot<List<Result>> snapshot) {
//             if (!snapshot.hasData) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Center(child: CircularProgressIndicator()),
//                 ],
//               );
//             } else if (snapshot.data.length == 0) {
//               return Column(
//                 children: <Widget>[
//                   Text(
//                     "No Results Found.",
//                   ),
//                 ],
//               );
//             } else {
//               var results = snapshot.data;
//               return ListView.builder(
//                 itemCount: results.length,
//                 itemBuilder: (context, index) {
//                   var result = results[index];
//                   return ListTile(
//                     title: Text(result.title),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // This method is called everytime the search term changes.
//     // If you want to add search suggestions as the user enters their search term, this is the place to do that.
//     return Column();
//   }
// }
