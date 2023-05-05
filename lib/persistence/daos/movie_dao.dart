import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

abstract class MovieDao{

  void saveMovies(List<MovieVO> movies);

  void saveSingleMovie(MovieVO? movie);

  MovieVO? getMovieById(int movieId);

  List<MovieVO> getAllMovies();

  Stream<void> getAllMoviesEventStream();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  Stream<List<MovieVO>> getPopularMoviesStream();

  Stream<List<MovieVO>> getTopRatedMoviesStream();

  List<MovieVO> getNowPlayingMovies();

  List<MovieVO> getPopularMovies();

  List<MovieVO> getTopRatedMovies();
}