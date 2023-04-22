import 'package:flutter/material.dart';
import 'package:movie_app/components/smart_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/movie_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;
  final List<MovieVO>? nowPlayingMovies;
  final String title;
  final Function onListEachReached;

  TitleAndHorizontalMovieListView(
      {required this.onTapMovie,
      required this.nowPlayingMovies,
      required this.title,
      required this.onListEachReached});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: TitleText(title)),
        SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListView(
          onTapMovie: (movieId) => this.onTapMovie(movieId),
          movieList: nowPlayingMovies,
          onListEndReached: () {
            this.onListEachReached();
          },
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  final Function onListEndReached;

  HorizontalMovieListView(
      {required this.onTapMovie,
      required this.movieList,
      required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          //     ? ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          //   itemCount: movieList?.length ?? 0,
          //   itemBuilder: (BuildContext context, int index) {
          //     return GestureDetector(
          //       onTap: () => onTapMovie(movieList?[index].id),
          //       child: MovieView(
          //         movie: movieList?[index],
          //       ),
          //     );
          //   },
          // )
          ? SmartHorizontalListView(
              itemCount: movieList?.length ?? 0,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemBuilder: (BuildContext context, int index) {
                return MovieView(
                  movie: movieList?[index],
                  onTapMovie: (movieId) {
                    this.onTapMovie(movieId);
                  },
                );
              },
              onListEndReached: () {
                this.onListEndReached();
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
