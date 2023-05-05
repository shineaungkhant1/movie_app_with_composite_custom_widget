import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/actor_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        GenreDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
        "Saving Now Playing Movies and Getting Now Playing Movies From Database",
        () {
      print("Void return call back works.......");
      expect(
        movieModel.getNowPlayingMoviesFromDatabase(),
        // Stream.value([
        //   MovieVO(
        //       false,
        //       "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
        //       [16, 12, 10751, 14, 35],
        //       null,
        //       null,
        //       null,
        //       null,
        //       502356,
        //       null,
        //       "en",
        //       "The Super Mario Bros. Movie",
        //       "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        //       8878.873,
        //       "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        //       null,
        //       null,
        //       null,
        //       null,
        //       "2023-04-05",
        //       null,
        //       null,
        //       null,
        //       "The Super Mario Bros. Movie",
        //       false,
        //       7.5,
        //       1618,
        //       isNowPlaying: true,
        //       isPopular: false,
        //       isTopRated: false)
        // ]),
        emits(
          [
            MovieVO(
                false,
                "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
                [16, 12, 10751, 14, 35],
                null,
                null,
                null,
                null,
                502356,
                null,
                "en",
                "The Super Mario Bros. Movie",
                "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                8878.873,
                "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                null,
                null,
                null,
                null,
                "2023-04-05",
                null,
                null,
                null,
                "The Super Mario Bros. Movie",
                false,
                7.5,
                1618,
                isNowPlaying: true,
                isPopular: false,
                isTopRated: false)
          ],
        ),
      );
    });

    test("Saving Popular Movies From Database", () {
      print("Void return call back works.......");
      expect(
        movieModel.getPopularMoviesFromDatabase(),
        // Stream.value([
        //   MovieVO(
        //       false,
        //       "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
        //       [16, 12, 10751, 14, 35],
        //       null,
        //       null,
        //       null,
        //       null,
        //       502356,
        //       null,
        //       "en",
        //       "The Super Mario Bros. Movie",
        //       "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        //       8878.873,
        //       "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        //       null,
        //       null,
        //       null,
        //       null,
        //       "2023-04-05",
        //       null,
        //       null,
        //       null,
        //       "The Super Mario Bros. Movie",
        //       false,
        //       7.5,
        //       1618,
        //       isNowPlaying: true,
        //       isPopular: false,
        //       isTopRated: false)
        // ]),
        emits(
          [
            MovieVO(
                false,
                "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
                [16, 12, 10751, 14, 35],
                null,
                null,
                null,
                null,
                502358,
                null,
                "en",
                "The Super Mario Bros. Movie",
                "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                8878.873,
                "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                null,
                null,
                null,
                null,
                "2023-04-05",
                null,
                null,
                null,
                "The Super Mario Bros. Movie",
                false,
                7.5,
                1618,
                isNowPlaying: false,
                isPopular: true,
                isTopRated: false)
          ],
        ),
      );
    });

    test("Saving TopRated Movies From Database", () {
      print("Void return call back works.......");
      expect(
        movieModel.getTopRatedMoviesFromDatabase(),
        // Stream.value([
        //   MovieVO(
        //       false,
        //       "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
        //       [16, 12, 10751, 14, 35],
        //       null,
        //       null,
        //       null,
        //       null,
        //       502356,
        //       null,
        //       "en",
        //       "The Super Mario Bros. Movie",
        //       "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        //       8878.873,
        //       "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        //       null,
        //       null,
        //       null,
        //       null,
        //       "2023-04-05",
        //       null,
        //       null,
        //       null,
        //       "The Super Mario Bros. Movie",
        //       false,
        //       7.5,
        //       1618,
        //       isNowPlaying: true,
        //       isPopular: false,
        //       isTopRated: false)
        // ]),
        emits(
          [
            MovieVO(
                false,
                "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
                [16, 12, 10751, 14, 35],
                null,
                null,
                null,
                null,
                502357,
                null,
                "en",
                "The Super Mario Bros. Movie",
                "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                8878.873,
                "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                null,
                null,
                null,
                null,
                "2023-04-05",
                null,
                null,
                null,
                "The Super Mario Bros. Movie",
                false,
                7.5,
                1618,
                isNowPlaying: false,
                isPopular: false,
                isTopRated: true)
          ],
        ),
      );
    });

    test(
      "Get Genres Test",
      () {
        expect(
          movieModel.getGenres(),
          completion(equals(getMockGenres())),
        );
      },
    );

    test(
      "Get Actors Test",
      () {
        expect(
          movieModel.getActors(1),
          completion(equals(getMockActors())),
        );
      },
    );

    test(
      "Get Credits Test",
      () {
        expect(
          movieModel.getCreditsByMovie(1),
          completion(equals(getMockCredits())),
        );
      },
    );

    test("Get Movie Details Test", () {
      expect(
          movieModel.getMovieDetails(1),
          completion(
            equals(getMockMoviesForTest().first),
          ));
    });

    test("Get Actors From Database Test", () async {
      await movieModel.getActors(1);
      expect(
          movieModel.getAllActorsFromDatabase(),
          completion(
            equals(getMockActors()),
          ));
    });

    test("Get Movie Details From Database Test", () async {
      await movieModel.getMovieDetails(1);
      expect(
          movieModel.getMovieDetails(1),
          completion(
            equals(getMockMoviesForTest().first),
          ));
    });

    test("Get Genres From Database Test", () async {
      await movieModel.getGenres();
      expect(
          movieModel.getGenresFromDatabase(),
          completion(
            equals(getMockGenres()),
          ));
    });
  });
}
