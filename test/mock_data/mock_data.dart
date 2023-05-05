import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
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
        isTopRated: false),
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
        isTopRated: false),
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
        isTopRated: true),
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(false, 1, 169337, [], "", "Gojo", 488.639,
        "/IuAlhI9eVC9Z8UQWOIDdWRKSEJ.png", "Gojo", 0, "", "", 0),
    ActorVO(false, 2, 2564437, [], "", "Sukuna", 75.172,
        "/IuAlhI9eVC9Z8UQWOIDdWRKSEJ.png", "Sukuna", 0, "", "", 0),
    ActorVO(false, 3, 220531, [], "", "Kirito", 488.639,
        "/IuAlhI9eVC9Z8UQWOIDdWRKSEJ.png", "Gojo", 0, "", "", 0),
  ];
}

List<GenreVO> getMockGenres(){
  return [
    GenreVO(1, "Action"),
    GenreVO(2, "Comedy"),
    GenreVO(3, "Adventure"),
  ];
}

List<List<ActorVO>> getMockCredits() {
  return [
    [
      ActorVO(false, 1, 123, [], "Actor", "Gojo", 89.12, "hello", "Gojo Satoru", 1, "Jujutsu Sorcerer", "1", 1),
      ActorVO(false, 2, 124, [], "Actor", "Gojo", 89.12, "hello", "Gojo Satoru", 2, "Jujutsu Sorcerer", "2", 2),
    ],
    [
      ActorVO(false, 3, 125, [], "Actor", "Gojo", 89.12, "hello", "Gojo Satoru", 3, "Jujutsu Sorcerer", "3", 3),
    ]
  ];
}




