import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import '../data/models/movie_model.dart';

class HomeBloc extends ChangeNotifier{
  /// States
   List<MovieVO>? mNowPlayingMovieList;
   List<MovieVO>? mPopularMoviesList;
   List<MovieVO>? mShowCaseMovieList;
   List<MovieVO>? mMoviesByGenreList;
   List<GenreVO>? mGenreList;
   List<ActorVO>? mActors;

   ///Page
   int pageForNowPlayingMovies = 1;

  /// Models
  MovieModel mMovieModel = MovieModelImpl();


  HomeBloc([MovieModel? movieModel]){
    /// Set Mock Model For Test Data
    if(movieModel != null){
      mMovieModel = movieModel;
    }

    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingMovieList=movieList;
      if(mNowPlayingMovieList?.isNotEmpty ?? false){
        mNowPlayingMovieList?.sort((a, b)=> (a.id ?? 0)-(b.id ?? 0));
      }
      notifyListeners();
    }).onError((error){
      print(error.toString());
    });

    /// Popular Movies Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesList=movieList;
      notifyListeners();
    }).onError((error){
      print(error.toString());
    });


    /// Genres
    mMovieModel.getGenres().then((genreList){
      mGenreList = genreList;
      getMoviesByGenreAndRefresh(genreList.first.id);
    }).catchError((error){
      print(error.toString());
    });


    /// Genre Database
    mMovieModel.getGenresFromDatabase().then((genreList){
      mGenreList = genreList;

      /// Movies By Genre
      if(mGenreList?.isNotEmpty ?? false){
        getMoviesByGenreAndRefresh(genreList.first.id);
      }
    }).catchError((error){
      print(error.toString());
    });


    /// Showcases Database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mShowCaseMovieList=movieList;
      notifyListeners();
    }).onError((error){
      print(error.toString());
    });


    /// Actors
    mMovieModel.getActors(1).then((actorList){
      mActors=actorList;
      notifyListeners();
    }).catchError((error){
      print(error.toString());
    });

    /// Actors Database
    mMovieModel.getAllActorsFromDatabase().then((actorList){
      mActors=actorList;
      notifyListeners();
    }).catchError((error){
      print(error.toString());
    });

  }

  void onTapGenre(int genreId){
    getMoviesByGenreAndRefresh(genreId);
  }

  void getMoviesByGenreAndRefresh(int genreId){
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
     mMoviesByGenreList = moviesByGenre??[];
     notifyListeners();
    }).catchError((error){
      print(error.toString());
    });
  }

  void onNowPlayingMovieListEndReached(){
    this.pageForNowPlayingMovies += 1;
    mMovieModel.getNowPlayingMovies(pageForNowPlayingMovies);
  }




}