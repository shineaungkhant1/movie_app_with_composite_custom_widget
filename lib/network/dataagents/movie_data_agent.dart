import 'package:movie_app/data/vos/movie_vo.dart';

import '../../data/vos/actor_vo.dart';
import '../../data/vos/genre_vo.dart';

abstract class MovieDataAgent{

  Future<List<MovieVO>?> getNowPlayingMovie(int page);
  Future<List<MovieVO>?> getPopularMovies(int page);
  Future<List<MovieVO>?> getTopRatedMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

}