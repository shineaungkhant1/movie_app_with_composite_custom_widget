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

  /// Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc(){
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingMovieList=movieList;
      notifyListeners();
    }).onError((error){
      print(error.toString());
    });

    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesList=movieList;
      notifyListeners();
    }).onError((error){
      print(error.toString());
    });

    mMovieModel.getGenres().then((genreList){
      mGenreList = genreList;
      getMoviesByGenreAndRefresh(genreList.first.id);
    }).catchError((error){
      print(error.toString());
    });


    mMovieModel.getGenresFromDatabase().then((genreList){
      mGenreList = genreList;
      getMoviesByGenreAndRefresh(genreList.first.id);
    }).catchError((error){
      print(error.toString());
    });

    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mShowCaseMovieList=movieList;
      notifyListeners();
    }).onError((error){
      print(error.toString());
    });

    mMovieModel.getActors(1).then((actorList){
      mActors=actorList;
      notifyListeners();
    }).catchError((error){
      print(error.toString());
    });

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




}