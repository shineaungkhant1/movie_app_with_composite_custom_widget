import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Details Bloc Test", () {
    MovieDetailsBLoc? movieDetailsBloc;

    setUp(() {
      movieDetailsBloc = MovieDetailsBLoc(1, MovieModelImplMock());
    });

    test("Fetch Movie Details Test", () {
      expect(movieDetailsBloc?.mMovie, getMockMoviesForTest().first);
    });

    test("Fetch Creators Test", () {
      expect(
          movieDetailsBloc?.mCrewList?.contains(getMockCredits().first.first),
          true);
    });

    test("Fetch Actors Test", () {
      expect(movieDetailsBloc?.mCastList?.contains(getMockCredits().first.last),
          true);
    });

    test("Fetch Related Movie", () async {
      movieDetailsBloc?.mRelatedMovies?[502356];
      await Future.delayed(const Duration(milliseconds: 500));
      expect(
          movieDetailsBloc?.mRelatedMovies?.contains(getMockMoviesForTest().first),
          true);
    });
  });
}
