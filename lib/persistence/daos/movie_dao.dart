import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class MovieDao{
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movies,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async{
    return getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId){
    return getMovieBox().get(movieId);
  }

  /// Reactive Programing

  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getPopularMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getTopRatedMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<void> getAllMoviesEventStream(){
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream(){
    return Stream.value(getAllMovies()
    .where((element) => element?.isNowPlaying ?? false)
    .toList()
    );
  }
  Stream<List<MovieVO>> getPopularMoviesStream(){
    return Stream.value(getAllMovies()
        .where((element) => element?.isPopular ?? false)
        .toList()
    );
  }
  Stream<List<MovieVO>> getTopRatedMoviesStream(){
    return Stream.value(getAllMovies()
        .where((element) => element?.isTopRated ?? false)
        .toList()
    );
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

}