import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';

import '../data/models/movie_model.dart';
import '../data/vos/movie_vo.dart';

class MovieDetailsBLoc extends ChangeNotifier{
  /// Stream Controllers
   MovieVO?  mMovie;
   List<ActorVO>? mCastList;
   List<ActorVO>? mCrewList;
   List<MovieVO>? mRelatedMovies;


  /// Models
   MovieModel mMovieModel = MovieModelImpl();

   MovieDetailsBLoc(int movieId){
     /// Movie Details
     mMovieModel.getMovieDetails(movieId)?.then((movie) {
      mMovie=movie;
      this.getRelatedMovies(movie.genres?.first.id??0);
      notifyListeners();
     });

     /// Movie Details From Database
     mMovieModel.getMovieDetailsFromFromDatabase(movieId)?.then((movie){
       mMovie=movie;
       notifyListeners();
     });

     mMovieModel.getCreditsByMovie(movieId)?.then((castAndCrew){
     mCastList=castAndCrew.first??[];
     mCrewList=castAndCrew.first??[];
     });

   }

   void getRelatedMovies(int genreId){
     mMovieModel.getMoviesByGenre(genreId)?.then((relatedMovies){
       mRelatedMovies = relatedMovies;
       notifyListeners();
     });
   }



}