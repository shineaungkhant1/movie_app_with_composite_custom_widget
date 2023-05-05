import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/home_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home Bloc Test", () {
    HomeBloc? homeBloc;

    setUp(() {
      homeBloc = HomeBloc(MovieModelImplMock());
    });

    test("Fetch Now Playing Movies Test", () {
      expect(
          homeBloc?.mNowPlayingMovieList
              ?.contains(getMockMoviesForTest().first),
          true);
    });

    test("Fetch Popular Movies Test", () {
      expect(homeBloc?.mPopularMoviesList?.contains(getMockMoviesForTest()[1]),
          true);
    });

    test("Fetch Top Rated Test", () {
      expect(
          homeBloc?.mShowCaseMovieList?.contains(getMockMoviesForTest().last),
          true);
    });

    test("Fetch Genre Test", () {
      expect(homeBloc?.mGenreList?.contains(getMockGenres().first), true);
    });

    test("Fetch Initial Movies By Genres Test", () async {
      await Future.delayed(const Duration(milliseconds: 500));
      expect(
          homeBloc?.mMoviesByGenreList?.contains(getMockMoviesForTest().first),
          true);
    });

    test("Fetch Actors Test", () {
      expect(homeBloc?.mActors?.contains(getMockActors().first), true);
    });

    test("Fetch Movies By Gnenre From User", () async {
      homeBloc?.onTapGenre(3);
      await Future.delayed(const Duration(milliseconds: 500));
      expect(
          homeBloc?.mMoviesByGenreList?.contains(getMockMoviesForTest().last),
          true);
    });

  });
}
