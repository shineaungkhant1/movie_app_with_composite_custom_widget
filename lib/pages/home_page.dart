import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/viewitems/bammer_view.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/actor_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';

import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';
import '../widgets/title_and_horizontal_movie_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Icon(
            Icons.menu,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                left: 0,
                bottom: 0,
                right: MARGIN_MEDIUM_2,
              ),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<HomeBloc, List<MovieVO>>(
                  selector: (context, bloc) => bloc.mPopularMoviesList ?? [],
                  builder: (context, popularMovieList, child) =>
                      BannerSectionView(
                    movieList: popularMovieList?.take(8)?.toList() ?? [],
                  ),
                ),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<MovieVO>>(
                  selector: (context, bloc) => bloc.mNowPlayingMovieList ?? [],
                  builder: (context, nowPlayingMovieList, child) =>
                      TitleAndHorizontalMovieListView(
                    /// Navigate
                    onTapMovie: (movieId) =>
                        _navigateToMovieDetailsScreen(context, movieId),
                    nowPlayingMovies: nowPlayingMovieList,
                    title: MAIN_SCREEN_BEST_POPULAR_MOVIE_AND_SERIALS,
                    onListEachReached: () {
                      var bloc = Provider.of<HomeBloc>(context, listen: false);
                      bloc.onNowPlayingMovieListEndReached();
                    },
                  ),
                ),
                SizedBox(height: MARGIN_LARGE),
                CheckMovieShowTimeSectionView(),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<GenreVO>>(
                  selector: (context, bloc) => bloc.mGenreList ?? [],
                  builder: (context, genreList, child) =>
                      Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mMoviesByGenreList ?? [],
                    builder: (context, movieByGenreList, child) =>
                        GenreSectionView(
                      /// Navigate to details screen
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailsScreen(context, movieId),
                      genreList: genreList,
                      onTapGenre: (genreId) {
                        HomeBloc bloc =
                            Provider.of<HomeBloc>(context, listen: false);
                        bloc.onTapGenre(genreId!);
                      },
                      moviesByGenre: movieByGenreList,
                    ),
                  ),
                ),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mShowCaseMovieList ?? [],
                    builder: (context, showCaseMovieList, child) =>
                        ShowcasesSection(topRatedMovies: showCaseMovieList)),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<ActorVO>>(
                    selector: (context, bloc) => bloc.mActors ?? [],
                    builder: (context, actors, child) =>
                        ActorsAndCreatorSectionView(
                            BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE,
                            actorsList: actors)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetalisPage(
            movieId: movieId,
          ),
        ),
      );
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onTapGenre;

  GenreSectionView(
      {required this.genreList,
      required this.moviesByGenre,
      required this.onTapMovie,
      required this.onTapGenre});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: MAIN_HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index) {
                onTapGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => this.onTapMovie(movieId),
            movieList: moviesByGenre,
            onListEndReached: () {},
          ),
        )
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  const CheckMovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: MOVIE_SHOW_TIMES_SECTION,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  late final List<MovieVO>? topRatedMovies;

  ShowcasesSection({required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: TitleTextWithSeeMoreView(
          SHOW_CASES_TITLE,
          SHOW_CASES_SEE_MORE,
        ),
      ),
      SizedBox(height: MARGIN_MEDIUM_2),
      Container(
        height: SHOW_CASES_HEIGHT,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          children: topRatedMovies
                  ?.map(
                    (topRatedMovies) => ShowCaseView(
                      movie: topRatedMovies,
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    ]);
  }
}

class BannerSectionView extends StatefulWidget {
  late final List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList
                    ?.map(
                      (movie) => BannerView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: (widget.movieList?.length == 0)
              ? 1
              : widget.movieList?.length ?? 1,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INCATIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        )
      ],
    );
  }
}
