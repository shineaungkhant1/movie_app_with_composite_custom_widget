import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  /// Network


  @override
  Future<List<ActorVO>> getActors(int page) {
    return mDataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors!);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return mDataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres!);
      return Future.value(genres);
    });
  }

  @override
  void getNowPlayingMovies(int page) {
    mDataAgent.getNowPlayingMovie(page).then((movies)async{
      List<MovieVO>? nowPlayingMovies = movies?.map((movie){
        movie.isTopRated = false;
        movie.isNowPlaying = true;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies!);
    });
  }

  @override
  void getTopRatedMovies(int page) {
    mDataAgent.getTopRatedMovies(page).then((movies)async{
      List<MovieVO>? topRatedMovies = movies?.map((movie){
        movie.isTopRated = true;
        movie.isNowPlaying = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(topRatedMovies!);
    });
  }

  @override
  void getPopularMovies(int page) {
   mDataAgent.getPopularMovies(page).then((movies)async{
     List<MovieVO>? popularMovies = movies?.map((movie){
       movie.isTopRated = false;
       movie.isNowPlaying = false;
       movie.isPopular = true;
       return movie;
     }).toList();
     mMovieDao.saveMovies(popularMovies!);
   });
  }


  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      mMovieDao.saveSingleMovie(movie!);
      return Future.value(movie);
    });
  }

  /// Hive
  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future<List<GenreVO>>.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies());
  }








}
