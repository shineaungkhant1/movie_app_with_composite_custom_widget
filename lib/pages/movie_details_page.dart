import 'package:flutter/material.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actor_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_and_horizontal_movie_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../blocs/home_bloc.dart';
import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/movie_vo.dart';

class MovieDetalisPage extends StatelessWidget {
  late final int movieId;

  MovieDetalisPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsBLoc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailsBLoc,MovieVO>(
          selector: (context,bloc)=>bloc.mMovie,
          builder: (context, movie, child) => Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: (movie != null)?CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(
                  () => Navigator.pop(context),
                  movie: movie,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                        child: TrailerSection(
                          genreList:
                          movie.getGenreListAsStringList() ,
                          storyLine: movie.overView ?? "",
                        ),
                      ),
                      SizedBox(height: MARGIN_LARGE),
                      Selector<MovieDetailsBLoc,List<ActorVO>>(
                        selector:(context,bloc)=> bloc.mCastList??[] ,
                        builder: (context,castList,child)=>ActorsAndCreatorSectionView(
                            MOVIE_DETAILS_SCREEN_ACTORS_TITLE, "",
                            seeMoreButtonVisibility: false,
                            actorsList: castList),
                      ),
                      SizedBox(height: MARGIN_LARGE),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                        child: AboutFlimSectionView(
                          movieVO:movie,
                        ),
                      ),
                      SizedBox(height: MARGIN_LARGE),

                      Selector<MovieDetailsBLoc,List<ActorVO>>(
                        selector: (context,bloc) => bloc.mCrewList??[],
                        builder: (context,crewList,child){
                          return (crewList != null && crewList.isNotEmpty)?ActorsAndCreatorSectionView(
                              MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                              MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                              actorsList: crewList):Container();
                        },
                      ),
                      SizedBox(height: MARGIN_LARGE),
                      Selector<MovieDetailsBLoc,List<MovieVO>?>(
                        selector: (context,bloc) => bloc.mRelatedMovies,
                        builder: (context,relatedMovies,child)=>TitleAndHorizontalMovieListView(
                          /// Navigate
                          onTapMovie: (movieId) =>
                              _navigateToMovieDetailsScreen(context, movieId),
                          nowPlayingMovies: relatedMovies, title: MOVIE_DETAILS_SCREEN_RELATED_MOVIES, onListEachReached: (){
                          // var bloc = Provider.of<HomeBloc>(context, listen: false);
                          // bloc.onNowPlayingMovieListEndReached();
                        },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ):const Center(
              child: CircularProgressIndicator(),
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

class AboutFlimSectionView extends StatelessWidget {
  late final MovieVO? movieVO;

  AboutFlimSectionView({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView("Original Title:", movieVO?.title ?? ""),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
            "Type:", movieVO?.getGenreListAsCommaSeparatedString() ?? ""),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView("Production:",
            movieVO?.getProductionCountriesAsComaSeparatedString() ?? ""),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView("Premiere:", movieVO?.releaseDate ?? ""),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView("Description:", movieVO?.overView ?? "")
      ],
    );
  }
}

class AboutFlimInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFlimInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
                color: MOVIE_DETAIL_INFO_TEXT_COLOR,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
                color: Colors.white,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  final String storyLine;

  TrailerSection({required this.genreList, required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(
          storyLine: this.storyLine,
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            MovieDetailsScreenButtonView(
                "PLAY TRAILER",
                PLAY_BUTTON_COLOR,
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.black54,
                )),
            SizedBox(width: MARGIN_CARD_MEDIUM_2),
            MovieDetailsScreenButtonView(
              "Rate MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(width: MARGIN_MEDIUM),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_2X),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  late final String storyLine;

  StoryLineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          storyLine,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  final List<String> genreList;

  MovieTimeAndGenreView({required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(width: MARGIN_SMALL),
        Text(
          "2h 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        ...genreList.map((genre) => GenreChipView(genre)).toList(),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: MARGIN_SMALL)
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final MovieVO? movie;
  final Function onTapBack;

  MovieDetailsSliverAppBarView(this.onTapBack, {required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetalisAppBarImageView(
                imageUrl: movie?.posterPath ?? "",
              ),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtomView(() => this.onTapBack()),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                    left: MARGIN_MEDIUM_2,
                  ),
                  child: SearchButtomView()),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailsAppBarInfoView(
                  movie: this.movie,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  late final MovieVO? movie;

  MovieDetailsAppBarInfoView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
              year: movie?.releaseDate?.substring(0, 4) ?? "",
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("${movie?.voteCount} VOTES"),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2),
                  ],
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Text(
                  movie?.voteAverage.toString() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          movie?.title ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  late final String year;

  MovieDetailsYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          year,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SearchButtomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtomView extends StatelessWidget {
  final Function onTapBack;

  BackButtomView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

class MovieDetalisAppBarImageView extends StatelessWidget {
  late final String imageUrl;

  MovieDetalisAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network("$IMAGE_BASE_URL$imageUrl", fit: BoxFit.cover);
  }
}
