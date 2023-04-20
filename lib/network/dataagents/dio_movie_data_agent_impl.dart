/*
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import '../../data/vos/movie_vo.dart';
import '../api_constant.dart';
import 'movie_data_agent.dart';

class DioMovieDataAgentImpl extends MovieDataAgent {
  @override
  Future<List<MovieVO>?> getNowPlayingMovie(int page) {
    Map<String, String> queryParameters = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString()
    };

   return Dio()
        .get("$BASE_URL_DIO$END_POINT_GET_NOW_PLAYING",
            queryParameters: queryParameters)
        .then((value) {
      debugPrint("Now Playing Movies ======>  ${value.toString()}");
    }).catchError((error) {
      debugPrint("Error  ======> ${error.toString()}");
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    // TODO: implement getActors
    throw UnimplementedError();
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    // TODO: implement getMoviesByGenre
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }
}
*/
